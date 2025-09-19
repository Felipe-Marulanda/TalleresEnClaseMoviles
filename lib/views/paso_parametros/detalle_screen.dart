import 'package:flutter/material.dart';

class DetalleScreen extends StatelessWidget {
  final String valor;

  const DetalleScreen({super.key, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          '🇧🇷 Detalle',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/brasil_bandera.jpg",
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.4)),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 8,
              color: Colors.yellow[700],
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Parámetro recibido: $valor",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
