import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/app_router.dart';
import 'services/auth_service.dart';
import 'providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure AuthService with your backend base URL if available.
  // Example: AuthService(backendBaseUrl: 'https://api.yourdomain.com')
  final authService = AuthService(backendBaseUrl: '');
  final authProvider = AuthProvider(service: authService);
  // Load persisted authentication state before the UI renders.
  await authProvider.loadFromStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007B3E)),
      useMaterial3: true,
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Parqueadero 2025',
      theme: baseTheme,
      routerConfig: appRouter,
    );
  }
}
