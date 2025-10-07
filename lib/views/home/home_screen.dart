import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          '🇧🇷 Menu Principal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _menuButton(
              context,
              title: "Detalle 123",
              icon: Icons.info,
              color: Colors.yellow[700]!,
              onTap: () => context.go('/detalle/123'),
              image: "assets/images/rio.jpg",
            ),
            _menuButton(
              context,
              title: "Detalle 456",
              icon: Icons.star,
              color: Colors.blue[600]!,
              onTap: () => context.push('/detalle/456'),
              image: "assets/images/futbol.jpg",
            ),
            _menuButton(
              context,
              title: "Detalle 789",
              icon: Icons.favorite,
              color: Colors.red[400]!,
              onTap: () => context.replace('/detalle/789'),
              image: "assets/images/samba.jpg",
            ),
            _menuButton(
              context,
              title: "Widgets Demo",
              icon: Icons.widgets,
              color: Colors.green[400]!,
              onTap: () => context.go('/widgets-demo'),
              image: "assets/images/playa.jpg",
            ),
            _menuButton(
              context,
              title: "Ciclo de Vida",
              icon: Icons.refresh,
              color: Colors.purple[400]!,
              onTap: () => context.go('/ciclo-vida'),
              image: "assets/images/rio.jpg",
            ),
            _menuButton(
              context,
              title: "Asincronía",
              icon: Icons.schedule,
              color: Colors.orange[400]!,
              onTap: () => context.go('/async-demo'),
              image: "assets/images/async.jpg",
            ),
            _menuButton(
              context,
              title: "Timer / Cronómetro",
              icon: Icons.timer,
              color: Colors.teal[400]!,
              onTap: () => context.go('/timer-demo'),
              image: "assets/images/timer.jpg",
            ),
            _menuButton(
              context,
              title: "Isolate - Tarea Pesada",
              icon: Icons.memory,
              color: Colors.indigo[400]!,
              onTap: () => context.go('/isolate-demo'),
              image: "assets/images/isolate.jpg",
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
        required String image,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: color),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
