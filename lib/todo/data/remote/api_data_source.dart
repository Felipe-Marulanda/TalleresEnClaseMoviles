import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/task.dart';

class ApiDataSource {
  final String baseUrl;
  final http.Client httpClient;

  ApiDataSource({
    required this.baseUrl,
    http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  // Create a task on the server
  Future<Task> createTask(Map<String, dynamic> taskData) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(taskData),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return Task.fromApi(data);
    } else {
      throw Exception('Failed to create task: ${response.statusCode}');
    }
  }

  // Update a task on the server
  Future<Task> updateTask(Map<String, dynamic> taskData) async {
    final taskId = taskData['id'] as String;
    final response = await httpClient.put(
      Uri.parse('$baseUrl/tasks/$taskId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(taskData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return Task.fromApi(data);
    } else {
      throw Exception('Failed to update task: ${response.statusCode}');
    }
  }

  // Delete a task from the server
  Future<void> deleteTask(String taskId) async {
    final response = await httpClient.delete(
      Uri.parse('$baseUrl/tasks/$taskId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete task: ${response.statusCode}');
    }
  }

  // Get all tasks from the server
  Future<List<Task>> getAllTasks() async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/tasks'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      return data.map((json) => Task.fromApi(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch tasks: ${response.statusCode}');
    }
  }

  // Get a specific task from the server
  Future<Task> getTask(String taskId) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/tasks/$taskId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return Task.fromApi(data);
    } else {
      throw Exception('Failed to fetch task: ${response.statusCode}');
    }
  }

  // Dispose resources
  void dispose() {
    httpClient.close();
  }
}