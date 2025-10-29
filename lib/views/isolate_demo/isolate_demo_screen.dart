import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Para usar compute
import 'package:go_router/go_router.dart';

import '../../utils/heavy_task.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';

class IsolateDemoScreen extends StatefulWidget {
  const IsolateDemoScreen({super.key});

  @override
  State<IsolateDemoScreen> createState() => _IsolateDemoScreenState();
}

class _IsolateDemoScreenState extends State<IsolateDemoScreen> {
  bool _isProcessing = false;
  String _result = '';

  Future<void> _runHeavyTask() async {
    setState(() {
      _isProcessing = true;
      _result = '';
    });

    try {
      // Ejecuta el isolate con 10 iteraciones (rápido y controlado)
      final result = await compute(heavyTask, 10);

      setState(() {
        _result = "✅ Hecho: Entrada ligera - iteraciones=10 - sum=$result";
      });
    } catch (e) {
      setState(() {
        _result = "❌ Error: $e";
      });
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Demo de Isolate'),
  drawer: CustomDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isProcessing ? null : _runHeavyTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[300],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Ejecutar Isolate'),
              ),
              const SizedBox(height: 20),
              if (_isProcessing)
                const CircularProgressIndicator()
              else
                Text(
                  _result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => context.goNamed('home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Volver al Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
