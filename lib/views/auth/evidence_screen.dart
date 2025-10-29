import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class EvidenceScreen extends StatelessWidget {
  const EvidenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Evidencia de Autenticación')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Autenticado: ${auth.isAuthenticated}'),
            const SizedBox(height: 8),
            Text('Token: ${auth.token ?? 'No token guardado'}'),
            const SizedBox(height: 8),
            Text('Usuario (shared_preferences):'),
            const SizedBox(height: 8),
            if (auth.user != null)
              Text(const JsonEncoder.withIndent('  ').convert(auth.user))
            else
              const Text('No hay información de usuario'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await auth.logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sesión cerrada')),
                );
              },
              child: const Text('Cerrar sesión y borrar almacenamiento'),
            ),
          ],
        ),
      ),
    );
  }
}
