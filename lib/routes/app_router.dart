import 'package:go_router/go_router.dart';

import '../models/meal.dart';
import '../views/async_demo/async_demo_screen.dart';
import '../views/categoria_fb/categoria_fb_form_view.dart';
import '../views/categoria_fb/categoria_fb_list_view.dart';
import '../views/ciclo_vida/ciclo_vida_screen.dart';
import '../views/home/home_screen.dart';
import '../views/isolate_demo/isolate_demo_screen.dart';
import '../views/meals/meal_detail_screen.dart';
import '../views/meals/meals_list_screen.dart';
import '../views/paso_parametros/detalle_screen.dart';
import '../views/paso_parametros/paso_parametros_screen.dart';
import '../views/profile/profile_screen.dart';
import '../views/settings/settings_screen.dart';
import '../views/timer_demo/timer_demo_screen.dart';
import '../views/widgets_demo/widgets_demo_screen.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/evidence_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/evidence',
      name: 'evidence',
      builder: (context, state) => const EvidenceScreen(),
    ),

    // Paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      name: 'paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),

    GoRoute(
      path: '/detalle/:valor/:metodo',
      name: 'detalle',
      builder: (context, state) {
        final valor = state.pathParameters['valor'] ?? 'Sin valor';
        final metodo = state.pathParameters['metodo'] ?? 'desconocido';
        return DetalleScreen(valor: valor, metodo: metodo);
      },
    ),

    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),

    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),

    // Widgets demo (GridView + TabBar)
    GoRoute(
      path: '/meals',
      name: 'meals',
      builder: (context, state) => const MealsListScreen(),
    ),

    GoRoute(
      path: '/meal_detail',
      name: 'meal_detail',
      builder: (context, state) {
        final meal = state.extra as Meal?;
        if (meal == null) {
          return const MealsListScreen();
        }
        return MealDetailScreen(meal: meal);
      },
    ),

    GoRoute(
      path: '/widgets_demo',
      name: 'widgets_demo',
      builder: (context, state) => const WidgetsDemoScreen(),
    ),

    // Ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      name: 'ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),

    // Async Demo
    GoRoute(
      path: '/async_demo',
      name: 'async_demo',
      builder: (context, state) => const AsyncDemoScreen(),
    ),

    // Timer Demo
    GoRoute(
      path: '/timer_demo',
      name: 'timer_demo',
      builder: (context, state) => const TimerDemoScreen(),
    ),

    // Isolate Demo
    GoRoute(
      path: '/isolate_demo',
      name: 'isolate_demo',
      builder: (context, state) => const IsolateDemoScreen(),
    ),

    // Categorías Firebase
    GoRoute(
      path: '/categoriasFirebase',
      name: 'categoriasFirebase',
      builder: (_, __) => const CategoriaFbListView(),
    ),

    GoRoute(
      path: '/categoriasfb/create',
      name: 'categoriasfb.create',
      builder: (context, state) => const CategoriaFbFormView(),
    ),
    
    GoRoute(
      path: '/categoriasfb/edit/:id',
      name: 'categorias.edit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return CategoriaFbFormView(id: id);
      },
    ),
  ],
);

