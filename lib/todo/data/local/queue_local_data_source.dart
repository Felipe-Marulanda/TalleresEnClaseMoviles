import '../../../todo/models/queue_operation.dart';
import 'database_helper.dart';

class QueueLocalDataSource {
  final DatabaseHelper _databaseHelper;

  QueueLocalDataSource({DatabaseHelper? databaseHelper}) 
      : _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

  // Add a new operation to the queue
  Future<void> enqueueOperation(QueueOperation operation) async {
    await _databaseHelper.insert(
      _databaseHelper.queueTable, 
      operation.toSqlite(),
    );
  }

  // Get all pending operations
  Future<List<QueueOperation>> getPendingOperations() async {
    final results = await _databaseHelper.query(
      _databaseHelper.queueTable,
      orderBy: 'created_at ASC',
    );

    return results.map((row) => QueueOperation.fromSqlite(row)).toList();
  }

  // Get operations for a specific entity
  Future<List<QueueOperation>> getOperationsForEntity(String entity, String entityId) async {
    final results = await _databaseHelper.query(
      _databaseHelper.queueTable,
      where: 'entity = ? AND entity_id = ?',
      whereArgs: [entity, entityId],
      orderBy: 'created_at ASC',
    );

    return results.map((row) => QueueOperation.fromSqlite(row)).toList();
  }

  // Update an operation (increment attempt count, set error)
  Future<void> updateOperation(QueueOperation operation) async {
    await _databaseHelper.update(
      _databaseHelper.queueTable,
      operation.toSqlite(),
      where: 'id = ?',
      whereArgs: [operation.id],
    );
  }

  // Remove an operation from the queue (after successful sync)
  Future<void> removeOperation(String operationId) async {
    await _databaseHelper.delete(
      _databaseHelper.queueTable,
      where: 'id = ?',
      whereArgs: [operationId],
    );
  }

  // Remove operations for a specific entity (useful after successful sync)
  Future<void> removeOperationsForEntity(String entity, String entityId) async {
    await _databaseHelper.delete(
      _databaseHelper.queueTable,
      where: 'entity = ? AND entity_id = ?',
      whereArgs: [entity, entityId],
    );
  }

  // Get operations with high attempt count (for error handling)
  Future<List<QueueOperation>> getFailedOperations(int maxAttempts) async {
    final results = await _databaseHelper.query(
      _databaseHelper.queueTable,
      where: 'attempt_count >= ?',
      whereArgs: [maxAttempts],
      orderBy: 'created_at DESC',
    );

    return results.map((row) => QueueOperation.fromSqlite(row)).toList();
  }

  // Get count of pending operations
  Future<int> getPendingOperationsCount() async {
    final results = await _databaseHelper.query(_databaseHelper.queueTable);
    return results.length;
  }

  // Clear all operations (for testing or manual reset)
  Future<void> clearAllOperations() async {
    await _databaseHelper.delete(_databaseHelper.queueTable);
  }

  // Get operations older than a specific time (for cleanup)
  Future<List<QueueOperation>> getOldOperations(Duration age) async {
    final cutoffTime = DateTime.now().subtract(age);
    final results = await _databaseHelper.query(
      _databaseHelper.queueTable,
      where: 'created_at < ?',
      whereArgs: [cutoffTime.millisecondsSinceEpoch],
      orderBy: 'created_at ASC',
    );

    return results.map((row) => QueueOperation.fromSqlite(row)).toList();
  }

  // Remove old operations (cleanup)
  Future<void> removeOldOperations(Duration age) async {
    final cutoffTime = DateTime.now().subtract(age);
    await _databaseHelper.delete(
      _databaseHelper.queueTable,
      where: 'created_at < ?',
      whereArgs: [cutoffTime.millisecondsSinceEpoch],
    );
  }

  // Check if there's already a pending operation for a specific entity and operation type
  Future<bool> hasPendingOperation(String entity, String entityId, OperationType operationType) async {
    final results = await _databaseHelper.query(
      _databaseHelper.queueTable,
      where: 'entity = ? AND entity_id = ? AND op = ?',
      whereArgs: [entity, entityId, operationType.name],
      limit: 1,
    );

    return results.isNotEmpty;
  }

  // Replace an existing operation (useful for updates)
  Future<void> replaceOperation(QueueOperation newOperation) async {
    await _databaseHelper.transaction((txn) async {
      // Remove existing operations for the same entity and operation type
      await txn.delete(
        _databaseHelper.queueTable,
        where: 'entity = ? AND entity_id = ? AND op = ?',
        whereArgs: [newOperation.entity, newOperation.entityId, newOperation.operation.name],
      );
      
      // Insert the new operation
      await txn.insert(_databaseHelper.queueTable, newOperation.toSqlite());
    });
  }
}