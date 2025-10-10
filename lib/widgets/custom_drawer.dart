import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary, // Usa el color primario del tema
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: Colors
                    .white, // Texto blanco para contrastar con el color primario
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              final router = GoRouter.of(context);
              Navigator.pop(context);
              router.goNamed('home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              final router = GoRouter.of(context);
              Navigator.pop(context);
              router.pushNamed('settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              final router = GoRouter.of(context);
              Navigator.pop(context);
              router.replaceNamed('profile');
            },
          ),
          //!PASO DE PARAMETROS
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Paso de Parámetros'),
            onTap: () {
              final router = GoRouter.of(context);
              Navigator.pop(context);
              router.goNamed('paso_parametros');
            },
          ),
          ListTile(
            leading: const Icon(Icons.loop),
            title: const Text('Ciclo de Vida'),
            onTap: () {
              final router = GoRouter.of(context);
              Navigator.pop(context);
              router.goNamed('ciclo_vida');
            },
          ),
        ],
      ),
    );
  }
}
