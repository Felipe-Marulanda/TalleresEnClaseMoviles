# JWT / Auth - Developer Notes

This file explains how the simple JWT client implemented in the project works and how to configure it to point to a real backend.

Overview
- `AuthService` (lib/services/auth_service.dart): performs login against `POST {baseUrl}/auth/login` and returns a map containing `token` and `user` by default. If `backendBaseUrl` is empty it returns a fake token for local testing.
- `AuthProvider` (lib/providers/auth_provider.dart): stateful provider that manages login/logout and persists `auth_token` into `flutter_secure_storage` and `user_info` (JSON) into `SharedPreferences`.
- `AppHttpClient` (lib/services/app_http_client.dart): automatically includes `Authorization: Bearer <token>` header when `auth_token` exists in secure storage.

How to configure to real backend
1. Open `lib/main.dart` and update the `AuthService` initialization:

```dart
// example
final authService = AuthService(backendBaseUrl: 'https://api.yourdomain.com');
```

2. Ensure your backend exposes a login endpoint that receives JSON `{ "email": "...", "password": "..." }` and returns 200 with JSON like:

```json
{
  "token": "eyJhbGciOiJI...",
  "user": {"email":"user@example.com","name":"Full Name","avatar":"https://.../photo.jpg"}
}
```

3. If your backend uses a different path (for example `/v1/login`), update `AuthService.login()` accordingly.

Notes on token usage
- `AppHttpClient` reads token from `flutter_secure_storage` key `auth_token` and injects it for every request. No further changes to existing API calls are required.
- Tokens are masked in logs (debug only).

Testing & manual checks
- Run unit tests:

```powershell
flutter pub get
flutter test test/auth_provider_test.dart
flutter test test/login_screen_test.dart
```

- Manual run (dev):

```powershell
flutter run
```

Security note
- Do not log tokens in production builds. `AppHttpClient` uses `kDebugMode` for safe debug prints.
