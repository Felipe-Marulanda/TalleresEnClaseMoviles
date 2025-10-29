import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';

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
    debugPrint('initState() -> se ejecuta al crear el widget');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didChangeDependencies() -> cuando cambian dependencias de contexto');
  }

  @override
  void dispose() {
    debugPrint('dispose() -> cuando el widget se elimina');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build() -> cada vez que se construye la UI');

    return Scaffold(
      appBar: const CustomAppBar(title: 'Ciclo de Vida'),
  drawer: CustomDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/cristo.jpg",
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withAlpha((255 * 0.5).round())),
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
                      debugPrint('setState() -> se llamo, se reconstruye el widget');
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
