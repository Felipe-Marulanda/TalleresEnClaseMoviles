# Taller HTTP y Navegación con GoRouter

Aplicación Flutter que consume la API pública [TheMealDB](https://www.themealdb.com/) para mostrar un recetario, explica diferentes formas de navegación con **go_router** y reúne demos de asincronía, isolates, timers y ciclo de vida de widgets.

---

## 🛰️ API consumida

- **Endpoint base:** `https://www.themealdb.com/api/json/v1/1/search.php?s=`
- **Descripción:** devuelve un listado de recetas; el parámetro `s` permite filtrar por texto (vacío trae 25 recetas destacadas).
- **Ejemplo de respuesta (fragmento):**

```json
{
  "meals": [
    {
      "idMeal": "52940",
      "strMeal": "Brown Stew Chicken",
      "strCategory": "Chicken",
      "strArea": "Jamaican",
      "strInstructions": "Season the chicken...",
      "strMealThumb": "https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg"
    }
  ]
}
```

El servicio HTTP está encapsulado en `lib/services/api_service.dart` y maneja estados de carga, error y datos vacíos desde la `HomePage`.

---

## 🧱 Arquitectura del proyecto

```
lib/
├── main.dart
├── routes/
│   └── app_router.dart         # Declaración central de go_router
├── models/
│   └── meal.dart               # Entidad utilizada en la vista de ejemplos
├── services/
│   └── api_service.dart        # Cliente HTTP para TheMealDB
├── views/
│   ├── home/                   # Listado principal (API) + detalle dinámico
│   ├── meals/                  # Ejemplo con datos estáticos (Meal model)
│   ├── async_demo/             # Uso de Future + estados de carga
│   ├── isolate_demo/           # Ejecución de tarea pesada con isolate
│   ├── timer_demo/             # Cronómetro con Timer.periodic
│   ├── ciclo_vida/             # Demostración del ciclo de vida de un StatefulWidget
│   ├── paso_parametros/        # Ejemplo de go/push/replace con parámetros
│   ├── profile/                # Pantalla estática con layout de perfil
│   ├── settings/               # Preferencias ficticias
│   └── widgets_demo/           # Grid + TabBar/TabBarView
└── widgets/
    ├── custom_appbar.dart      # AppBar con navegación superior
    ├── custom_drawer.dart      # Drawer lateral reutilizable
    └── item_card.dart          # Card reutilizable para recetas
```


---

## 🧭 Rutas y parámetros (go_router)

| Ruta | Nombre | Widget | Parámetros |
|------|--------|--------|------------|
| `/` | `home` | `HomeScreen` | – |
| `/paso_parametros` | `paso_parametros` | `PasoParametrosScreen` | – |
| `/detalle/:valor/:metodo` | `detalle` | `DetalleScreen` | `valor` y `metodo` en `pathParameters` |
| `/settings` | `settings` | `SettingsScreen` | – |
| `/profile` | `profile` | `ProfileScreen` | – |
| `/meals` | `meals` | `MealsListScreen` | – |
| `/meal_detail` | `meal_detail` | `MealDetailScreen` | Objeto `Meal` vía `state.extra` |
| `/widgets_demo` | `widgets_demo` | `WidgetsDemoScreen` | – |
| `/ciclo_vida` | `ciclo_vida` | `CicloVidaScreen` | – |
| `/async_demo` | `async_demo` | `AsyncDemoScreen` | – |
| `/timer_demo` | `timer_demo` | `TimerDemoScreen` | – |
| `/isolate_demo` | `isolate_demo` | `IsolateDemoScreen` | – |

En la `HomePage` se muestran los resultados consumidos desde la API; al tocar cada card se navega mediante `Navigator.push` a `MealDetailPage` para presentar la ficha completa con chips, ingredientes y pasos.

---

## ⚙️ Estados de carga y manejo de errores

- **Loading:** `CircularProgressIndicator` centralizado mientras se espera la respuesta HTTP.
- **Error:** mensaje textual con el detalle del error (`snapshot.error`).
- **Empty:** mensaje “No hay datos disponibles” cuando la API responde sin elementos.

Las otras pantallas (`async_demo`, `timer_demo`, `isolate_demo`) exponen ejemplos controlados de asincronía, timers y cómputo en segundo plano.


## ▶️ Ejecución

```bash
flutter pub get
flutter run -d chrome      # o flutter run para dispositivo físico/emulador
```

## Capturas
![alt text](<Captura de pantalla 2025-10-10 012455.png>)
![alt text](<Captura de pantalla 2025-10-10 012520.png>)

## Checklist rápida

- [x] Consumo real de API externa (TheMealDB).
- [x] Navegación declarativa con go_router y parámetros.
- [x] Manejo de estados (carga, éxito, error, vacío).
- [x] Demos adicionales (async, isolate, timer, ciclo de vida, widgets).

---

## 🔥 Firebase - Gestión de Categorías

Se añadió integración completa con Firebase/Firestore para gestionar una colección de categorías:

- **Colección Firestore:** `categorias` con campos: nombre, descripcion
- **Operaciones CRUD:** Crear, listar (stream tiempo real), editar, eliminar categorías
- **UI:** Listado en tiempo real y formulario de creación/edición con validación

Cómo probar:

1. Ejecuta la app: `flutter run`
2. Abre el Drawer → `Categorías Firebase`
3. Crea nuevas categorías usando el botón "+"
4. Observa cómo la lista se actualiza en tiempo real
5. Edita o elimina categorías existentes

Archivos principales:
- `lib/models/categoria_fb.dart` - Modelo de datos
- `lib/models/categoria_service.dart` - Servicio Firebase CRUD
- `lib/views/categoria_fb/` - Pantallas de listado y formulario
