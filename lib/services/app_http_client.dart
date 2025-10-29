import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Lightweight HTTP client that automatically injects Authorization header
/// reading the token from `flutter_secure_storage` under key `auth_token`.
class AppHttpClient {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, String>> _buildHeaders(Map<String, String>? headers) async {
    final token = await _secureStorage.read(key: 'auth_token');
    final result = <String, String>{};
    if (headers != null) result.addAll(headers);
    if (token != null && token.isNotEmpty) {
      result['Authorization'] = 'Bearer $token';
    }
    // Debug: log header keys and whether Authorization is present (mask token)
    if (kDebugMode) {
      final hasAuth = result.containsKey('Authorization');
      final masked = hasAuth ? 'Bearer •••••${token!.substring(token.length - 6)}' : 'no';
      debugPrint('AppHttpClient: built headers (hasAuth=$hasAuth, tokenPreview=$masked)');
    }
    return result;
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final h = await _buildHeaders(headers);
    if (kDebugMode) debugPrint('AppHttpClient GET: ${url.toString()}');
    return http.get(url, headers: h);
  }

  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final h = await _buildHeaders(headers);
    if (kDebugMode) debugPrint('AppHttpClient POST: ${url.toString()} body=${body != null}');
    return http.post(url, headers: h, body: body, encoding: encoding);
  }

  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final h = await _buildHeaders(headers);
    if (kDebugMode) debugPrint('AppHttpClient PUT: ${url.toString()} body=${body != null}');
    return http.put(url, headers: h, body: body, encoding: encoding);
  }

  Future<http.Response> delete(Uri url, {Map<String, String>? headers}) async {
    final h = await _buildHeaders(headers);
    if (kDebugMode) debugPrint('AppHttpClient DELETE: ${url.toString()}');
    return http.delete(url, headers: h);
  }
}
