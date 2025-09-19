import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurante ETIOPIA',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFFDF6EC), // Beige cálido
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4E342E), // Marrón café
          foregroundColor: Colors.white,
          elevation: 5,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Georgia'),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _title = "Hola, Flutter";

  void _cambiarTitulo() {
    setState(() {
      _title = _title == "Hola, Flutter" ? "¡Título cambiado!" : "Hola, Flutter";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Título actualizado"),
        backgroundColor: Colors.brown,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: const TextStyle(
            fontFamily: "Georgia",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo del restaurante
            Center(
              child: Image.asset(
                "assets/img/eti.jpg",
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),

            // Eslogan con estilo
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEF6C00), Color(0xFFFFA726)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: const Text(
                "JUAN FELIPE CASTRO MARULANDA",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Botón con estilo
            ElevatedButton.icon(
              onPressed: _cambiarTitulo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                "Cambiar Título",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // Grid de imágenes con bordes redondeados
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildFoodCard(
                    "Bandeja Paisa",
                    "https://media.istockphoto.com/id/1416777077/photo/paisa-tray.jpg?s=612x612&w=0&k=20&c=tQWK2KJyOltcLmh2mFhOctCMeLXrGk5LmXUWRnBor8k=",
                  ),
                  _buildFoodCard(
                    "Paella",
                    "https://www.goya.com/wp-content/uploads/2023/10/goya-shrimp-paella.jpg",
                  ),
                  _buildFoodCard(
                    "Frijolada",
                    "https://redifood.co/cdn/shop/articles/DALL_E_2025-03-04_13.10.44_-_A_rustic_bowl_filled_with_traditional_frijolada_a_hearty_bean_stew_garnished_with_fresh_cilantro._The_dish_is_accompanied_by_side_plates_of_white_ri.webp?v=1741090364",
                  ),
                  _buildFoodCard(
                    "Sushi",
                    "https://cdn.pixabay.com/photo/2023/07/07/17/47/sushi-8113165_1280.jpg",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Menú en ListView estilizado
            Expanded(
              child: ListView(
                children: const [
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.restaurant, color: Colors.brown),
                      title: Text("Bandeja Paisa"),
                      subtitle: Text(
                        "Plato típico colombiano con fríjoles, arroz, chicharrón, huevo frito, arepa, chorizo, aguacate y carne molida.",
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.rice_bowl, color: Colors.brown),
                      title: Text("Paella"),
                      subtitle: Text(
                        "Plato español a base de arroz, mariscos, pollo y verduras, condimentado con azafrán.",
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.local_dining, color: Colors.brown),
                      title: Text("Frijolada"),
                      subtitle: Text(
                        "Plato brasileño hecho con frijoles negros, carnes de cerdo y res, servido con arroz y naranja.",
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.set_meal, color: Colors.brown),
                      title: Text("Sushi"),
                      subtitle: Text(
                        "Plato japonés con arroz avinagrado acompañado de pescado, mariscos o vegetales.",
                      ),
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

  // Widget para cada plato en la grilla
  Widget _buildFoodCard(String name, String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(imageUrl, fit: BoxFit.cover),
          Container(
            color: Colors.black38,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(6),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black,
                    offset: Offset(1, 1),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}