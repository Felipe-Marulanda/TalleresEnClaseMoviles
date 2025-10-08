import 'package:go_router/go_router.dart';
import 'package:parqueadero_2025_g2/views/async_demo/async_demo_screen.dart';
import 'package:parqueadero_2025_g2/views/timer_demo/timer_demo_screen.dart';
import 'package:parqueadero_2025_g2/views/isolate_demo/isolate_demo_screen.dart';
import 'package:parqueadero_2025_g2/views/home/home_screen.dart';
import 'package:parqueadero_2025_g2/views/paso_parametros/detalle_screen.dart';
import 'package:parqueadero_2025_g2/views/widgets_demo/widgets_demo_screen.dart';
import 'package:parqueadero_2025_g2/views/ciclo_vida/ciclo_vida_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Paso de parámetros
    GoRoute(
      path: '/detalle/:valor',
      name: 'detalle',
      builder: (context, state) {
        final valor = state.pathParameters['valor'] ?? 'Sin valor';
        return DetalleScreen(valor: valor);
      },
    ),

    // Widgets demo (GridView + TabBar)
    GoRoute(
      path: '/widgets-demo',
      name: 'widgetsDemo',
      builder: (context, state) => const WidgetsDemoScreen(),
    ),

    // Ciclo de vida
    GoRoute(
      path: '/ciclo-vida',
      name: 'cicloVida',
      builder: (context, state) => const CicloVidaScreen(),
    ),

    // Async Demo
    GoRoute(
      path: '/async-demo',
      builder: (context, state) => const AsyncDemoScreen(),
    ),

    // Timer Demo
    GoRoute(
      path: '/timer-demo',
      builder: (context, state) => const TimerDemoScreen(),
    ),

    // Isolate Demo
    GoRoute(
      path: '/isolate-demo',
      builder: (context, state) => const IsolateDemoScreen(),
    ),
  ],

  

);

