import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstractions around secure storage and shared preferences to allow easy
/// dependency injection and testing.
abstract class SecureStorageInterface {
  Future<String?> read(String key);
  Future<void> write(String key, String? value);
  Future<void> delete(String key);
}

class RealSecureStorage implements SecureStorageInterface {
  final FlutterSecureStorage _impl;
  RealSecureStorage([FlutterSecureStorage? impl]) : _impl = impl ?? const FlutterSecureStorage();

  @override
  Future<void> delete(String key) => _impl.delete(key: key);

  @override
  Future<String?> read(String key) => _impl.read(key: key);

  @override
  Future<void> write(String key, String? value) => _impl.write(key: key, value: value);
}

abstract class PreferencesInterface {
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);
  Future<void> remove(String key);
}

class RealPreferences implements PreferencesInterface {
  final SharedPreferences _prefs;
  RealPreferences(this._prefs);

  static Future<RealPreferences> getInstance() async {
    final p = await SharedPreferences.getInstance();
    return RealPreferences(p);
  }

  @override
  Future<String?> getString(String key) async => _prefs.getString(key);

  @override
  Future<void> setString(String key, String value) async => _prefs.setString(key, value);

  @override
  Future<void> remove(String key) async => _prefs.remove(key);
}
