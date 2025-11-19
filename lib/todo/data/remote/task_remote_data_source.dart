import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../todo/models/task.dart';

// Custom exceptions for better error handling
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => 'ApiException: $message';
}

class NetworkException extends ApiException {
  NetworkException(super.message);
  @override
  String toString() => 'NetworkException: $message';
}

class BadRequestException extends ApiException {
  BadRequestException(super.message);
  @override
  String toString() => 'BadRequestException: $message';
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message);
  @override
  String toString() => 'UnauthorizedException: $message';
}

class ForbiddenException extends ApiException {
  ForbiddenException(super.message);
  @override
  String toString() => 'ForbiddenException: $message';
}

class NotFoundException extends ApiException {
  NotFoundException(super.message);
  @override
  String toString() => 'NotFoundException: $message';
}

class ConflictException extends ApiException {
  ConflictException(super.message);
  @override
  String toString() => 'ConflictException: $message';
}

class ValidationException extends ApiException {
  ValidationException(super.message);
  @override
  String toString() => 'ValidationException: $message';
}

class ServerException extends ApiException {
  ServerException(super.message);
  @override
  String toString() => 'ServerException: $message';
}

class BadGatewayException extends ApiException {
  BadGatewayException(super.message);
  @override
  String toString() => 'BadGatewayException: $message';
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException(super.message);
  @override
  String toString() => 'ServiceUnavailableException: $message';
}

class TaskRemoteDataSource {
  final String baseUrl;
  final http.Client _client;
  final Duration timeout;

  TaskRemoteDataSource({
    required this.baseUrl,
    http.Client? client,
    this.timeout = const Duration(seconds: 10),
  }) : _client = client ?? http.Client();

  // Generate headers with idempotency key
  Map<String, String> _getHeaders({String? idempotencyKey}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (idempotencyKey != null) {
      headers['Idempotency-Key'] = idempotencyKey;
    }
    
    return headers;
  }

  // Handle HTTP errors
  void _handleHttpError(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException('Bad request: ${response.body}');
      case 401:
        throw UnauthorizedException('Unauthorized access');
      case 403:
        throw ForbiddenException('Access forbidden');
      case 404:
        throw NotFoundException('Resource not found');
      case 409:
        throw ConflictException('Resource conflict: ${response.body}');
      case 422:
        throw ValidationException('Validation error: ${response.body}');
      case 500:
        throw ServerException('Internal server error');
      case 502:
        throw BadGatewayException('Bad gateway');
      case 503:
        throw ServiceUnavailableException('Service temporarily unavailable');
      default:
        throw HttpException('HTTP error ${response.statusCode}: ${response.body}');
    }
  }

  // Get all tasks from API
  Future<List<Task>> getAllTasks() async {
    try {
      final response = await _client
          .get(
            Uri.parse('$baseUrl/tasks'),
            headers: _getHeaders(),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Task.fromApi(json)).toList();
      }

      _handleHttpError(response);
      return [];
    } on SocketException {
      throw NetworkException('No internet connection');
    } on HttpException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to fetch tasks: $e');
    }
  }

  // Get a specific task by ID
  Future<Task?> getTaskById(String id) async {
    try {
      final response = await _client
          .get(
            Uri.parse('$baseUrl/tasks/$id'),
            headers: _getHeaders(),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Task.fromApi(json);
      }

      if (response.statusCode == 404) {
        return null; // Task not found
      }

      _handleHttpError(response);
      return null;
    } on SocketException {
      throw NetworkException('No internet connection');
    } on HttpException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to fetch task: $e');
    }
  }

  // Create a new task
  Future<Task> createTask(Task task, {String? idempotencyKey}) async {
    try {
      final response = await _client
          .post(
            Uri.parse('$baseUrl/tasks'),
            headers: _getHeaders(idempotencyKey: idempotencyKey),
            body: jsonEncode(task.toApi()),
          )
          .timeout(timeout);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Task.fromApi(json);
      }

      _handleHttpError(response);
      return task; // Fallback
    } on SocketException {
      throw NetworkException('No internet connection');
    } on HttpException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to create task: $e');
    }
  }

  // Update an existing task
  Future<Task> updateTask(Task task, {String? idempotencyKey}) async {
    try {
      final response = await _client
          .put(
            Uri.parse('$baseUrl/tasks/${task.id}'),
            headers: _getHeaders(idempotencyKey: idempotencyKey),
            body: jsonEncode(task.toApi()),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Task.fromApi(json);
      }

      _handleHttpError(response);
      return task; // Fallback
    } on SocketException {
      throw NetworkException('No internet connection');
    } on HttpException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to update task: $e');
    }
  }

  // Delete a task
  Future<void> deleteTask(String id, {String? idempotencyKey}) async {
    try {
      final response = await _client
          .delete(
            Uri.parse('$baseUrl/tasks/$id'),
            headers: _getHeaders(idempotencyKey: idempotencyKey),
          )
          .timeout(timeout);

      if (response.statusCode == 200 || 
          response.statusCode == 204 || 
          response.statusCode == 404) {
        // Success or already deleted
        return;
      }

      _handleHttpError(response);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on HttpException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to delete task: $e');
    }
  }

  // Get tasks modified after a specific timestamp (for sync)
  Future<List<Task>> getTasksModifiedAfter(DateTime timestamp) async {
    try {
      final queryParams = {
        'modifiedAfter': timestamp.toIso8601String(),
      };

      final uri = Uri.parse('$baseUrl/tasks').replace(queryParameters: queryParams);
      
      final response = await _client
          .get(uri, headers: _getHeaders())
          .timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Task.fromApi(json)).toList();
      }

      _handleHttpError(response);
      return [];
    } on SocketException {
      throw NetworkException('No internet connection');
    } on HttpException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to fetch modified tasks: $e');
    }
  }

  // Health check endpoint
  Future<bool> isHealthy() async {
    try {
      final response = await _client
          .get(
            Uri.parse('$baseUrl/health'),
            headers: _getHeaders(),
          )
          .timeout(const Duration(seconds: 5));

      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      return false;
    }
  }

  // Dispose of the HTTP client
  void dispose() {
    _client.close();
  }
}