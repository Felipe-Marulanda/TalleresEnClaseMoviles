import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../services/auth_service.dart';
import '../services/storage.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _service;
  final SecureStorageInterface? _secureStorageInterface;
  final PreferencesInterface? _preferencesInterface;

  bool _isLoading = false;
  String? _token;
  Map<String, dynamic>? _user;
  String? _error;

  bool get isLoading => _isLoading;
  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;
  String? get error => _error;

  AuthProvider({required AuthService service, SecureStorageInterface? secureStorageInterface, PreferencesInterface? preferencesInterface})
      : _service = service,
        _secureStorageInterface = secureStorageInterface,
        _preferencesInterface = preferencesInterface;

  Future<void> loadFromStorage() async {
    final secure = _secureStorageInterface ?? RealSecureStorage();
    final prefs = _preferencesInterface ?? await RealPreferences.getInstance();

    _token = await secure.read('auth_token');
    final userJson = await prefs.getString('user_info');
    if (userJson != null) {
      try {
        _user = jsonDecode(userJson) as Map<String, dynamic>;
      } catch (_) {
        _user = null;
      }
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final resp = await _service.login(email, password);
      final t = resp['token'] as String?;
      final u = resp['user'] as Map<String, dynamic>?;
      if (t == null) throw Exception('No token in response');

      _token = t;
      _user = u ?? {'email': email};
      // persist
      final secure = _secureStorageInterface ?? RealSecureStorage();
      final prefs = _preferencesInterface ?? await RealPreferences.getInstance();
      await secure.write('auth_token', _token);
      await prefs.setString('user_info', jsonEncode(_user));

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    final secure = _secureStorageInterface ?? RealSecureStorage();
    final prefs = _preferencesInterface ?? await RealPreferences.getInstance();
    await secure.delete('auth_token');
    await prefs.remove('user_info');
    notifyListeners();
  }
}
