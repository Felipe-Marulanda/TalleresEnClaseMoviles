import 'package:flutter/material.dart';

class CicloVidaScreen extends StatefulWidget {
  const CicloVidaScreen({super.key});

  @override
  State<CicloVidaScreen> createState() => _CicloVidaScreenState();
}

class _CicloVidaScreenState extends State<CicloVidaScreen> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    print("initState() → se ejecuta al crear el widget");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies() → cuando cambian dependencias de contexto");
  }

  @override
  void dispose() {
    print("dispose() → cuando el widget se elimina");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build() → cada vez que se construye la UI");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: const Text("🇧🇷 Ciclo de Vida", style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/cristo.jpg",
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Counter: $counter",
                  style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    foregroundColor: Colors.green[900],
                  ),
                  onPressed: () {
                    setState(() {
                      counter++;
                      print("setState() → se llamó, se reconstruye el widget");
                    });
                  },
                  child: const Text("Incrementar"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
