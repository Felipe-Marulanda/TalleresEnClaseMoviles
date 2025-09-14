# talleres_moviles - Evidencias
JUAN FELIPE CASTRO MARULANDA - 230222039

Código base (ejemplo con setState, SnackBar y 2 widgets extra)
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String titulo = "Hola, Flutter";
  int contador = 0;

  void _cambiarTitulo() {
    setState(() {
      titulo = "Título cambiado";
      contador++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("El título fue cambiado")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _cambiarTitulo,
                child: Text("Cambiar Título"),
              ),
              const SizedBox(height: 20),
              // Widget adicional 1: contador
              Text("Veces que se cambió el título: $contador",
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              // Widget adicional 2: switch
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Modo oscuro:"),
                  Switch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            value
                                ? "Activaste el modo oscuro"
                                : "Desactivaste el modo oscuro",
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


## Descripción breve
Este proyecto corresponde al taller de Flutter donde se implementa el uso de `setState()` para manejar estados, mostrando el cambio de un título y el uso de un `SnackBar`.  
Adicionalmente, se agregaron dos widgets: un contador de veces que se cambia el título y un interruptor (Switch) para simular un cambio de modo.

## Pasos para ejecutar
1. Clonar este repositorio o descargar el proyecto.
2. En la carpeta raíz, ejecutar:
   ```bash
   flutter pub get
   flutter run

## Capturas

Estado inicial de la app.
<img width="528" height="888" alt="Captura de pantalla 2025-09-14 104237" src="https://github.com/user-attachments/assets/125bc941-2af9-4810-a30d-db04a3f49dc7" />

Estado tras presionar el botón (título cambiado + SnackBar).
<img width="527" height="886" alt="Captura de pantalla 2025-09-14 104257" src="https://github.com/user-attachments/assets/be8edc5f-ef59-4517-953e-46931a28e231" />
