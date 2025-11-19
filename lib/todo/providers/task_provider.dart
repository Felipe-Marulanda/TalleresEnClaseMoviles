import 'package:flutter/foundation.dart';

import '../models/task.dart';
import '../models/enums.dart';
import '../data/repository/task_repository.dart';
import '../services/sync_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository;
  final SyncService _syncService;

  // State
  List<Task> _tasks = [];
  TaskFilter _currentFilter = TaskFilter.all;
  bool _isLoading = false;
  String? _error;
  Map<TaskFilter, int> _taskCounts = {};

  // Getters
  List<Task> get tasks => _tasks;
  TaskFilter get currentFilter => _currentFilter;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<TaskFilter, int> get taskCounts => _taskCounts;
  
  // Computed getters
  List<Task> get pendingTasks => _tasks.where((task) => !task.completed).toList();
  List<Task> get completedTasks => _tasks.where((task) => task.completed).toList();
  int get totalTasks => _tasks.length;
  int get pendingCount => pendingTasks.length;
  int get completedCount => completedTasks.length;

  TaskProvider({
    required TaskRepository repository,
    required SyncService syncService,
  }) : _repository = repository,
       _syncService = syncService {
    _initialize();
  }

  // Initialize provider
  Future<void> _initialize() async {
    await loadTasks();
    await _updateTaskCounts();
  }

  // Load tasks with current filter
  Future<void> loadTasks() async {
    _setLoading(true);
    _setError(null);

    try {
      _tasks = await _repository.getAllTasks(filter: _currentFilter);
      await _updateTaskCounts();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Create a new task
  Future<void> createTask(String title) async {
    if (title.trim().isEmpty) return;

    _setLoading(true);
    _setError(null);

    try {
      final newTask = await _repository.createTask(title.trim());
      
      // Add to local list if it matches current filter
      if (_shouldShowTask(newTask)) {
        _tasks.insert(0, newTask); // Insert at top
      }
      
      await _updateTaskCounts();
      notifyListeners();
    } catch (e) {
      _setError('Failed to create task: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    _setError(null);

    try {
      final updatedTask = await _repository.updateTask(task);
      
      // Update in local list
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        if (_shouldShowTask(updatedTask)) {
          _tasks[index] = updatedTask;
        } else {
          _tasks.removeAt(index); // Remove if no longer matches filter
        }
      }
      
      await _updateTaskCounts();
      notifyListeners();
    } catch (e) {
      _setError('Failed to update task: $e');
    }
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(Task task) async {
    await updateTask(task.copyWith(completed: !task.completed));
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    _setError(null);

    try {
      await _repository.deleteTask(taskId);
      
      // Remove from local list
      _tasks.removeWhere((task) => task.id == taskId);
      
      await _updateTaskCounts();
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete task: $e');
    }
  }

  // Change filter
  Future<void> setFilter(TaskFilter filter) async {
    if (_currentFilter == filter) return;

    _currentFilter = filter;
    await loadTasks();
  }

  // Refresh tasks (pull-to-refresh)
  Future<void> refreshTasks() async {
    try {
      await _syncService.manualSync();
    } catch (e) {
      // Manual sync failed, just reload from local
    }
    await loadTasks();
  }

  // Clear all completed tasks
  Future<void> clearCompletedTasks() async {
    try {
      final pendingTasks = _tasks.where((task) => !task.completed).toList();
      
      for (final task in completedTasks) {
        await _repository.deleteTask(task.id);
      }
      
      await loadTasks();
    } catch (e) {
      _setError('Failed to clear completed tasks: $e');
    }
  }

  // Mark all pending tasks as completed
  Future<void> markAllAsCompleted() async {
    try {
      final pendingTasks = _tasks.where((task) => !task.completed).toList();
      
      for (final task in pendingTasks) {
        await _repository.updateTask(task.copyWith(completed: true));
      }
      
      await loadTasks();
    } catch (e) {
      _setError('Failed to mark all tasks as completed: $e');
    }
  }

  // Update task counts for all filters
  Future<void> _updateTaskCounts() async {
    try {
      _taskCounts = await _repository.getTaskCounts();
    } catch (e) {
      // Silently fail - counts are not critical
    }
  }

  // Check if task should be shown with current filter
  bool _shouldShowTask(Task task) {
    switch (_currentFilter) {
      case TaskFilter.all:
        return true;
      case TaskFilter.pending:
        return !task.completed;
      case TaskFilter.completed:
        return task.completed;
    }
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error state
  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _setError(null);
  }

  // Search tasks
  List<Task> searchTasks(String query) {
    if (query.trim().isEmpty) return _tasks;
    
    final lowercaseQuery = query.toLowerCase();
    return _tasks.where((task) =>
        task.title.toLowerCase().contains(lowercaseQuery)
    ).toList();
  }

  @override
  void dispose() {
    super.dispose();
  }
}