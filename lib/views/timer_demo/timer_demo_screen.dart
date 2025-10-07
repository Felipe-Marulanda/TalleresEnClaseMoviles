import 'dart:async';
import 'package:flutter/material.dart';

class TimerDemoScreen extends StatefulWidget {
  const TimerDemoScreen({super.key});

  @override
  State<TimerDemoScreen> createState() => _TimerDemoScreenState();
}

class _TimerDemoScreenState extends State<TimerDemoScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return; // 🔒 evita múltiples timers
    _isRunning = true;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
  }

  void _resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    setState(() {
      _seconds = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Timer / Cronómetro")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$_seconds s", style: TextStyle(fontSize: 48)),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: _startTimer, child: Text("Iniciar")),
                ElevatedButton(onPressed: _pauseTimer, child: Text("Pausar")),
                ElevatedButton(onPressed: _resetTimer, child: Text("Reiniciar")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
