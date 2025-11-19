import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uuid/uuid.dart';

import '../../models/task.dart';
import '../../models/queue_operation.dart';
import '../../models/enums.dart';
import '../local/task_local_data_source.dart';
import '../local/queue_local_data_source.dart';
import '../remote/task_remote_data_source.dart';

class TaskRepository {
  final TaskLocalDataSource _localDataSource;
  final QueueLocalDataSource _queueDataSource;
  final TaskRemoteDataSource _remoteDataSource;
  final Connectivity _connectivity;
  final Uuid _uuid = const Uuid();

  TaskRepository({
    required TaskLocalDataSource localDataSource,
    required QueueLocalDataSource queueDataSource,
    required TaskRemoteDataSource remoteDataSource,
    Connectivity? connectivity,
  }) : _localDataSource = localDataSource,
       _queueDataSource = queueDataSource,
       _remoteDataSource = remoteDataSource,
       _connectivity = connectivity ?? Connectivity();

  // Check if device has internet connectivity
  Future<bool> _hasConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Get all tasks with offline-first approach
  Future<List<Task>> getAllTasks({TaskFilter filter = TaskFilter.all}) async {
    // Always return local data first (offline-first)
    final localTasks = await _localDataSource.getAllTasks(filter: filter);
    
    // Try to sync in the background if connected
    if (await _hasConnectivity()) {
      _syncInBackground();
    }
    
    return localTasks;
  }

  // Get a specific task by ID
  Future<Task?> getTaskById(String id) async {
    // Always check local first
    final localTask = await _localDataSource.getTaskById(id);
    
    if (localTask != null) {
      return localTask;
    }
    
    // If not found locally and we have connectivity, try remote
    if (await _hasConnectivity()) {
      try {
        final remoteTask = await _remoteDataSource.getTaskById(id);
        if (remoteTask != null) {
          // Save to local for future offline access
          await _localDataSource.createTask(remoteTask);
          return remoteTask;
        }
      } catch (e) {
        // Remote fetch failed, continue with local data
      }
    }
    
    return null;
  }

  // Create a new task
  Future<Task> createTask(String title) async {
    final now = DateTime.now();
    final task = Task(
      id: _uuid.v4(),
      title: title,
      completed: false,
      updatedAt: now,
    );

    // Save locally first (offline-first)
    await _localDataSource.createTask(task);

    // Queue operation for sync
    await _enqueueOperation(
      OperationType.create,
      task.id,
      task.toApi(),
    );

    // Try immediate sync if connected
    if (await _hasConnectivity()) {
      _syncInBackground();
    }

    return task;
  }

  // Update an existing task
  Future<Task> updateTask(Task task) async {
    final updatedTask = task.copyWith(updatedAt: DateTime.now());

    // Update locally first
    await _localDataSource.updateTask(updatedTask);

    // Queue operation for sync
    await _enqueueOperation(
      OperationType.update,
      updatedTask.id,
      updatedTask.toApi(),
    );

    // Try immediate sync if connected
    if (await _hasConnectivity()) {
      _syncInBackground();
    }

    return updatedTask;
  }

  // Delete a task
  Future<void> deleteTask(String id) async {
    // Soft delete locally first
    await _localDataSource.deleteTask(id);

    // Queue operation for sync
    await _enqueueOperation(
      OperationType.delete,
      id,
      {'id': id},
    );

    // Try immediate sync if connected
    if (await _hasConnectivity()) {
      _syncInBackground();
    }
  }

  // Toggle task completion
  Future<Task> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(
      completed: !task.completed,
      updatedAt: DateTime.now(),
    );

    return await updateTask(updatedTask);
  }

  // Get task counts for dashboard/stats
  Future<Map<TaskFilter, int>> getTaskCounts() async {
    final allCount = await _localDataSource.getTaskCount(filter: TaskFilter.all);
    final pendingCount = await _localDataSource.getTaskCount(filter: TaskFilter.pending);
    final completedCount = await _localDataSource.getTaskCount(filter: TaskFilter.completed);

    return {
      TaskFilter.all: allCount,
      TaskFilter.pending: pendingCount,
      TaskFilter.completed: completedCount,
    };
  }

  // Get sync status
  Future<SyncStatus> getSyncStatus() async {
    if (!await _hasConnectivity()) {
      return SyncStatus.offline;
    }

    final pendingOperations = await _queueDataSource.getPendingOperationsCount();
    if (pendingOperations == 0) {
      return SyncStatus.synced;
    }

    // Check if there are failed operations
    final failedOperations = await _queueDataSource.getFailedOperations(3);
    if (failedOperations.isNotEmpty) {
      return SyncStatus.error;
    }

    return SyncStatus.syncing;
  }

  // Force sync (manual trigger)
  Future<void> forceSync() async {
    if (!await _hasConnectivity()) {
      throw Exception('No internet connection available');
    }

    await _performSync();
  }

  // Background sync (fire and forget)
  void _syncInBackground() {
    _performSync().catchError((error) {
      // Log error but don't propagate (background operation)
      print('Background sync failed: $error');
    });
  }

  // Perform actual synchronization
  Future<void> _performSync() async {
    try {
      // First, sync from server to local (download changes)
      await _syncFromServer();
      
      // Then, sync local changes to server (upload changes)
      await _syncToServer();
    } catch (e) {
      print('Sync failed: $e');
      rethrow;
    }
  }

  // Sync changes from server to local
  Future<void> _syncFromServer() async {
    try {
      // Get all tasks from server
      final remoteTasks = await _remoteDataSource.getAllTasks();
      
      // Bulk update local database with server data
      await _localDataSource.bulkUpsertTasks(remoteTasks);
    } catch (e) {
      print('Sync from server failed: $e');
      // Don't rethrow - we want to continue with local-to-server sync
    }
  }

  // Sync local changes to server
  Future<void> _syncToServer() async {
    final pendingOperations = await _queueDataSource.getPendingOperations();

    for (final operation in pendingOperations) {
      try {
        await _processOperation(operation);
        // Remove successful operation from queue
        await _queueDataSource.removeOperation(operation.id);
      } catch (e) {
        // Update operation with error and increment attempt count
        final updatedOperation = operation.copyWith(
          attemptCount: operation.attemptCount + 1,
          lastError: e.toString(),
        );
        await _queueDataSource.updateOperation(updatedOperation);
        
        // If too many attempts, log and continue with next operation
        if (updatedOperation.attemptCount >= 3) {
          print('Operation ${operation.id} failed after 3 attempts: $e');
        }
      }
    }
  }

  // Process a single operation
  Future<void> _processOperation(QueueOperation operation) async {
    switch (operation.operation) {
      case OperationType.create:
        final task = Task.fromApi(operation.payload);
        await _remoteDataSource.createTask(task, idempotencyKey: operation.id);
        break;
        
      case OperationType.update:
        final task = Task.fromApi(operation.payload);
        await _remoteDataSource.updateTask(task, idempotencyKey: operation.id);
        break;
        
      case OperationType.delete:
        await _remoteDataSource.deleteTask(
          operation.entityId, 
          idempotencyKey: operation.id,
        );
        break;
    }
  }

  // Enqueue an operation for later sync
  Future<void> _enqueueOperation(
    OperationType operationType,
    String entityId,
    Map<String, dynamic> payload,
  ) async {
    final operation = QueueOperation(
      id: _uuid.v4(),
      entity: 'task',
      entityId: entityId,
      operation: operationType,
      payload: payload,
      createdAt: DateTime.now(),
    );

    // For updates, replace existing operation to avoid conflicts
    if (operationType == OperationType.update) {
      await _queueDataSource.replaceOperation(operation);
    } else {
      await _queueDataSource.enqueueOperation(operation);
    }
  }

  // Clean up old operations (call periodically)
  Future<void> cleanupOldOperations() async {
    const maxAge = Duration(days: 7);
    await _queueDataSource.removeOldOperations(maxAge);
  }

  // Get pending operations count (for UI)
  Future<int> getPendingOperationsCount() async {
    return await _queueDataSource.getPendingOperationsCount();
  }

  // Clear all local data (for testing/debugging)
  Future<void> clearAllData() async {
    await _localDataSource.clearAllTasks();
    await _queueDataSource.clearAllOperations();
  }

  // Check API health
  Future<bool> checkApiHealth() async {
    if (!await _hasConnectivity()) {
      return false;
    }
    
    try {
      return await _remoteDataSource.isHealthy();
    } catch (e) {
      return false;
    }
  }

  // Stream connectivity changes
  Stream<ConnectivityResult> get connectivityStream => _connectivity.onConnectivityChanged;
}