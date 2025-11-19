import '../../../todo/models/task.dart';
import '../../../todo/models/enums.dart';
import 'database_helper.dart';

class TaskLocalDataSource {
  final DatabaseHelper _databaseHelper;

  TaskLocalDataSource({DatabaseHelper? databaseHelper}) 
      : _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

  // Create a new task
  Future<void> createTask(Task task) async {
    await _databaseHelper.insert(
      _databaseHelper.tasksTable, 
      task.toSqlite(),
    );
  }

  // Get all tasks with optional filter
  Future<List<Task>> getAllTasks({TaskFilter filter = TaskFilter.all}) async {
    String? whereClause;
    List<dynamic>? whereArgs;

    // Apply filter
    switch (filter) {
      case TaskFilter.pending:
        whereClause = 'completed = ? AND deleted = ?';
        whereArgs = [0, 0];
        break;
      case TaskFilter.completed:
        whereClause = 'completed = ? AND deleted = ?';
        whereArgs = [1, 0];
        break;
      case TaskFilter.all:
        whereClause = 'deleted = ?';
        whereArgs = [0];
        break;
    }

    final results = await _databaseHelper.query(
      _databaseHelper.tasksTable,
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'updated_at DESC',
    );

    return results.map((row) => Task.fromSqlite(row)).toList();
  }

  // Get a specific task by ID
  Future<Task?> getTaskById(String id) async {
    final results = await _databaseHelper.query(
      _databaseHelper.tasksTable,
      where: 'id = ? AND deleted = ?',
      whereArgs: [id, 0],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return Task.fromSqlite(results.first);
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    await _databaseHelper.update(
      _databaseHelper.tasksTable,
      task.toSqlite(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Soft delete a task (mark as deleted)
  Future<void> deleteTask(String id) async {
    final now = DateTime.now();
    await _databaseHelper.update(
      _databaseHelper.tasksTable,
      {
        'deleted': 1,
        'updated_at': now.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Hard delete a task (permanent removal)
  Future<void> hardDeleteTask(String id) async {
    await _databaseHelper.delete(
      _databaseHelper.tasksTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get tasks that are newer than a specific timestamp (for sync)
  Future<List<Task>> getTasksModifiedAfter(DateTime timestamp) async {
    final results = await _databaseHelper.query(
      _databaseHelper.tasksTable,
      where: 'updated_at > ?',
      whereArgs: [timestamp.toIso8601String()],
      orderBy: 'updated_at ASC',
    );

    return results.map((row) => Task.fromSqlite(row)).toList();
  }

  // Bulk insert/update tasks (for sync from server)
  Future<void> bulkUpsertTasks(List<Task> tasks) async {
    await _databaseHelper.transaction((txn) async {
      for (final task in tasks) {
        // Check if task already exists
        final existing = await txn.query(
          _databaseHelper.tasksTable,
          where: 'id = ?',
          whereArgs: [task.id],
          limit: 1,
        );

        if (existing.isEmpty) {
          // Insert new task
          await txn.insert(_databaseHelper.tasksTable, task.toSqlite());
        } else {
          // Update existing task if server version is newer
          final existingTask = Task.fromSqlite(existing.first);
          if (task.updatedAt.isAfter(existingTask.updatedAt)) {
            await txn.update(
              _databaseHelper.tasksTable,
              task.toSqlite(),
              where: 'id = ?',
              whereArgs: [task.id],
            );
          }
        }
      }
    });
  }

  // Get count of tasks by filter
  Future<int> getTaskCount({TaskFilter filter = TaskFilter.all}) async {
    String? whereClause;
    List<dynamic>? whereArgs;

    switch (filter) {
      case TaskFilter.pending:
        whereClause = 'completed = ? AND deleted = ?';
        whereArgs = [0, 0];
        break;
      case TaskFilter.completed:
        whereClause = 'completed = ? AND deleted = ?';
        whereArgs = [1, 0];
        break;
      case TaskFilter.all:
        whereClause = 'deleted = ?';
        whereArgs = [0];
        break;
    }

    final results = await _databaseHelper.query(
      _databaseHelper.tasksTable,
      where: whereClause,
      whereArgs: whereArgs,
    );

    return results.length;
  }

  // Clear all tasks (for testing)
  Future<void> clearAllTasks() async {
    await _databaseHelper.delete(_databaseHelper.tasksTable);
  }

  // Get all tasks including deleted ones (for debugging)
  Future<List<Task>> getAllTasksIncludingDeleted() async {
    final results = await _databaseHelper.query(
      _databaseHelper.tasksTable,
      orderBy: 'updated_at DESC',
    );

    return results.map((row) => Task.fromSqlite(row)).toList();
  }
}