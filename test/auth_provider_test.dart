import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:parqueadero_2025_g2/providers/auth_provider.dart';
import 'package:parqueadero_2025_g2/services/auth_service.dart';
import 'package:parqueadero_2025_g2/services/storage.dart';

/// In-memory fake implementations for storage interfaces.
class InMemorySecureStorage implements SecureStorageInterface {
  final Map<String, String?> _map = {};
  @override
  Future<void> delete(String key) async => _map.remove(key);

  @override
  Future<String?> read(String key) async => _map[key];

  @override
  Future<void> write(String key, String? value) async => _map[key] = value;
}

class InMemoryPreferences implements PreferencesInterface {
  final Map<String, String> _map = {};
  @override
  Future<String?> getString(String key) async => _map[key];

  @override
  Future<void> remove(String key) async => _map.remove(key);

  @override
  Future<void> setString(String key, String value) async => _map[key] = value;
}

class FakeAuthService extends AuthService {
  FakeAuthService() : super(backendBaseUrl: '');

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    // return a deterministic token and user
    await Future.delayed(const Duration(milliseconds: 10));
    return {'token': 'TEST.TOKEN.123456', 'user': {'email': email, 'name': 'Test User'}};
  }
}

void main() {
  test('AuthProvider login stores token and user; logout clears them', () async {
    final secure = InMemorySecureStorage();
    final prefs = InMemoryPreferences();
    final service = FakeAuthService();
    final provider = AuthProvider(service: service, secureStorageInterface: secure, preferencesInterface: prefs);

    // initially nothing
    await provider.loadFromStorage();
    expect(provider.isAuthenticated, isFalse);

    final ok = await provider.login('a@b.com', 'pw');
    expect(ok, isTrue);
    expect(provider.isAuthenticated, isTrue);
    expect(provider.token, 'TEST.TOKEN.123456');
    expect(provider.user?['email'], 'a@b.com');

    // check underlying storages
    final storedToken = await secure.read('auth_token');
    expect(storedToken, 'TEST.TOKEN.123456');
    final storedUser = await prefs.getString('user_info');
    expect(jsonDecode(storedUser!), isA<Map>());

    await provider.logout();
    expect(provider.isAuthenticated, isFalse);
    expect(await secure.read('auth_token'), isNull);
    expect(await prefs.getString('user_info'), isNull);
  });
}
