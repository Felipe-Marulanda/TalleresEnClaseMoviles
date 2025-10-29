import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:parqueadero_2025_g2/views/auth/login_screen.dart';
import 'package:parqueadero_2025_g2/providers/auth_provider.dart';
import 'package:parqueadero_2025_g2/services/auth_service.dart';
import 'package:parqueadero_2025_g2/services/storage.dart';

class FakeAuthService extends AuthService {
  FakeAuthService() : super(backendBaseUrl: '');
  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return {'token': 'WIDGET.TEST.TOKEN', 'user': {'email': email, 'name': 'Widget Tester'}};
  }
}

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

void main() {
  testWidgets('LoginScreen submits and authenticates provider', (tester) async {
    final service = FakeAuthService();
    final secure = InMemorySecureStorage();
    final prefs = InMemoryPreferences();
    final provider = AuthProvider(service: service, secureStorageInterface: secure, preferencesInterface: prefs);

    await provider.loadFromStorage();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<AuthProvider>.value(
          value: provider,
          child: const LoginScreen(),
        ),
      ),
    );

    // find fields and button
    final emailField = find.byType(TextFormField).first;
    final passField = find.byType(TextFormField).at(1);
    final loginButton = find.text('Iniciar sesión');

    await tester.enterText(emailField, 'w@test.com');
    await tester.enterText(passField, 'password');
    await tester.tap(loginButton);

    // Let the async login complete
    await tester.pumpAndSettle();

    expect(provider.isAuthenticated, isTrue);
    expect(provider.user?['email'], 'w@test.com');
  });
}
