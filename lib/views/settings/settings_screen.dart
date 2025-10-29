import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Configuracion'),
  drawer: CustomDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SettingsSection(
            title: 'Preferencias generales',
            children: [
              _SettingsTile(icon: Icons.palette, title: 'Tema', subtitle: 'Claro / Oscuro'),
              _SettingsTile(icon: Icons.notifications, title: 'Notificaciones'),
            ],
          ),
          SizedBox(height: 24),
          _SettingsSection(
            title: 'Privacidad',
            children: [
              _SettingsTile(icon: Icons.lock, title: 'Cambiar contrasena'),
              _SettingsTile(icon: Icons.shield, title: 'Permisos de datos'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const _SettingsTile({required this.icon, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
