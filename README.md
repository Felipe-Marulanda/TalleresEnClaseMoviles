# Taller2 Navegación y Ciclo de Vida

## Descripción
Este proyecto implementa navegación con **go_router**, paso de parámetros entre pantallas, uso de diferentes widgets intermedios y evidencia del ciclo de vida de un **StatefulWidget**.  
El objetivo es comprender las diferencias entre `go`, `push` y `replace`, el envío de datos entre pantallas y el momento de ejecución de los métodos principales de un widget con estado.

---

## Arquitectura / Navegación
La navegación está implementada con **go_router**, definiendo un conjunto de rutas principales:

- `/` → **HomeScreen**  
  Pantalla principal con botones de navegación.

- `/detalle/:valor` → **DetalleScreen**  
  Pantalla que recibe un parámetro dinámico (`valor`) desde el Home y lo muestra en la interfaz.
    - Ejemplo: `/detalle/123` muestra el detalle del parámetro `123`.

- `/widgets-demo` → **WidgetsDemoScreen**  
  Pantalla para probar distintos widgets intermedios como **GridView** y **TabBar**.

- `/ciclo-vida` → **CicloVidaScreen**  
  Pantalla que evidencia la ejecución de los métodos de ciclo de vida de un `StatefulWidget` (`initState`, `didChangeDependencies`, `build`, `setState`, `dispose`).

### Comportamiento de `go`, `push` y `replace`
- **go** → Cambia la ruta sin mantener historial (no aparece botón back).
- **push** → Agrega la ruta al stack (aparece botón back en la AppBar).
- **replace** → Reemplaza la ruta actual (no mantiene historial, similar a `go`).

---

## Widgets Usados
1. **GridView**
    - Permite mostrar una lista de elementos en formato de cuadrícula.
    - Se eligió porque organiza visualmente imágenes y botones de forma atractiva.

2. **TabBar + TabBarView**
    - Implementa secciones en una sola pantalla con pestañas.
    - Se eligió porque es útil para organizar contenidos diferentes en una misma vista, mejorando la experiencia de usuario.

3. **ElevatedButton con imágenes e íconos**
    - Botones con estilos personalizados que navegan a las diferentes rutas.
    - Se eligieron porque hacen la navegación más intuitiva y atractiva.

4. **StatefulWidget (Ciclo de vida)**
    - En la pantalla de ciclo de vida, se usó un widget con estado para imprimir en consola los métodos principales.

---

## Evidencia del ciclo de vida
En la pantalla **CicloVidaScreen** se registran en consola los siguientes métodos del ciclo de vida:

- `initState()`  
  Se ejecuta una sola vez al inicializar el widget. Sirve para preparar datos iniciales.

- `didChangeDependencies()`  
  Se llama cuando cambian las dependencias del widget. Útil para acceder a información de contexto que pueda variar.

- `build()`  
  Se ejecuta cada vez que se construye/redibuja la interfaz gráfica.

- `setState()`  
  Se usa cuando se cambia el estado de una variable y se desea reconstruir la UI para reflejar el cambio.

- `dispose()`  
  Se ejecuta al destruir el widget, ideal para liberar recursos o cancelar streams.

### Ejemplo de comentarios en el código:
```dart
@override
void initState() {
  super.initState();
  print("initState: Se ejecuta al crear el widget por primera vez.");
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  print("didChangeDependencies: Se ejecuta cuando cambian las dependencias.");
}

@override
Widget build(BuildContext context) {
  print("build: Se ejecuta cada vez que se dibuja la interfaz.");
  return Scaffold(...);
}

void _incrementarContador() {
  setState(() {
    contador++;
    print("setState: Se actualiza el estado y se reconstruye la UI.");
  });
}

@override
void dispose() {
  print("dispose: Se ejecuta al destruir el widget y limpiar recursos.");
  super.dispose();
}

 Estructura de carpetas

lib/
├── main.dart
├── routes/
│   └── app_router.dart
└── views/
    ├── home/
    │   └── home_screen.dart
    ├── detalle/
    │   └── detalle_screen.dart
    ├── widgets_demo/
    │   └── widgets_demo_screen.dart
    └── ciclo_vida/
        └── ciclo_vida_screen.dart

 Ejecución

1.Instalar dependencias:

flutter pub get


2.Ejecutar en dispositivo o navegador:

flutter run


 Estilos

El proyecto usa colores e imágenes con temática brasileña para dar un diseño atractivo y consistente:

Amarillo y verde predominantes.

Botones con íconos e imágenes decorativas.

Estilo alegre y llamativo en las pantallas.