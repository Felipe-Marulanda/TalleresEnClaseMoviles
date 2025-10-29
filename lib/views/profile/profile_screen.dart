import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final name = auth.user?['name']?.toString() ?? 'Usuario invitado';
    final email = auth.user?['email']?.toString() ?? 'invitado@correo.com';

    return Scaffold(
      appBar: const CustomAppBar(title: 'Perfil'),
  drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Builder(builder: (ctx) {
                  final avatarUrl = auth.user?['avatar']?.toString();
                  if (avatarUrl != null && avatarUrl.isNotEmpty) {
                    return CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(avatarUrl),
                    );
                  }
                  // fallback: initials from name
                  final initials = (name.split(' ').where((s) => s.isNotEmpty).map((s) => s[0]).take(2).join()).toUpperCase();
                  return CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(initials, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  );
                }),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(email),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Progreso', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey[300],
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 24),
            const Text('Actividades recientes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: const [
                  _ActivityTile(icon: Icons.check_circle, text: 'Completaste el taller Async'),
                  _ActivityTile(icon: Icons.timer, text: 'Usaste el demo de Timer'),
                  _ActivityTile(icon: Icons.book, text: 'Consultaste recetas del recetario'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ActivityTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(text),
      ),
    );
  }
}
