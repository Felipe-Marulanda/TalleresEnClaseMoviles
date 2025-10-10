import 'package:flutter/material.dart';
import '../../services/fake_service.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';

class AsyncDemoScreen extends StatefulWidget {
  const AsyncDemoScreen({super.key});

  @override
  State<AsyncDemoScreen> createState() => _AsyncDemoScreenState();
}

class _AsyncDemoScreenState extends State<AsyncDemoScreen> {
  String message = "Presiona el botón para iniciar consulta";

  Future<void> _loadData() async {
    setState(() => message = "Cargando...");
    final result = await FakeService().getData();
    setState(() => message = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Async Future-await'),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadData,
              child: Text("Consultar"),
            )
          ],
        ),
      ),
    );
  }
}
