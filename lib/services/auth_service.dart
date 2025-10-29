import 'dart:convert';

import 'package:http/http.dart' as http;

/// Simple AuthService that performs login against a configurable backend.
///
/// If [backendBaseUrl] is left empty, this service will simulate a successful
/// login and return a dummy JWT token. Adjust endpoints as needed to match
/// your real backend (e.g. POST /auth/login returning { token, user }).
class AuthService {
  // Set this to your project backend base URL (no trailing slash). If empty,
  // service will return a fake token to let the client flow be exercised.
  final String backendBaseUrl;

  AuthService({this.backendBaseUrl = ''});

  Future<Map<String, dynamic>> login(String email, String password) async {
    if (backendBaseUrl.isEmpty) {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      // Return a fake token and user object
      return {
        'token': 'FAKE.JWT.TOKEN.EXAMPLE',
        'user': {'email': email, 'name': 'Demo User'}
      };
    }

    final url = Uri.parse('$backendBaseUrl/auth/login');
    final resp = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}));

    if (resp.statusCode == 200) {
      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      // Expecting body to contain token and user
      return body;
    }

    throw Exception('Login failed: ${resp.statusCode}');
  }
}
