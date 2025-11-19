# 📱 Parqueadero 2025 G2 - Flutter App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Material Design](https://img.shields.io/badge/Material%20Design-0081CB?style=for-the-badge&logo=material-design&logoColor=white)

**Aplicación Flutter multiplataforma con gestión de estado avanzada, Firebase integration y arquitectura offline-first**

[📱 Demo](#demo) • [🚀 Instalación](#instalación) • [📖 Documentación](#documentación) • [🧪 Testing](#testing)

</div>

---

## 📋 Tabla de Contenidos

- [🎯 Descripción](#-descripción)
- [🏗️ Arquitectura](#️-arquitectura)
- [💻 Tecnologías](#-tecnologías)
- [📁 Estructura del Proyecto](#-estructura-del-proyecto)
- [🚀 Instalación y Configuración](#-instalación-y-configuración)
- [▶️ Ejecución](#️-ejecución)
- [🧪 Testing Offline y Sincronización](#-testing-offline-y-sincronización)
- [📱 Funcionalidades](#-funcionalidades)
- [🎨 Capturas de Pantalla](#-capturas-de-pantalla)
- [🤝 Contribución](#-contribución)
- [📄 Licencia](#-licencia)

---

## 🎯 Descripción

**Parqueadero 2025 G2** es una aplicación Flutter multiplataforma que demuestra la implementación de:

- ✅ **Gestores de Estado Avanzados** (Provider, setState, Stream)
- ✅ **Arquitectura Offline-First** con sincronización automática
- ✅ **Integración Firebase** (Firestore, Authentication)
- ✅ **Material Design 3** con temas personalizados
- ✅ **Navegación Declarativa** con GoRouter
- ✅ **Gestión de Datos Local** (SQLite, Secure Storage)
- ✅ **Patrón Repository** y Clean Architecture
- ✅ **Conectividad y Sincronización** inteligente

### 🎯 Objetivos Académicos

Esta aplicación fue desarrollada como proyecto educativo para demostrar:
- Implementación de diferentes patrones de gestión de estado
- Arquitectura offline-first con sincronización de datos
- Integración con servicios de backend (Firebase)
- Buenas prácticas en desarrollo móvil con Flutter

---

## 🏗️ Arquitectura

### 📊 Patrón Arquitectónico: **Clean Architecture + Repository Pattern**

```
┌─────────────────────┐
│   Presentation      │  ← Widgets, Screens, Providers
├─────────────────────┤
│   Domain           │  ← Models, Use Cases, Repositories (Abstract)
├─────────────────────┤
│   Data             │  ← Repository Implementations, Data Sources
├─────────────────────┤
│   External         │  ← Firebase, SQLite, HTTP, Storage
└─────────────────────┘
```

### 🔄 **Gestores de Estado Implementados**

| Gestor de Estado | Uso en la App | Complejidad |
|-----------------|---------------|-------------|
| **setState()** | Ciclo de Vida, Contadores | 🟢 Básica |
| **Provider** | Autenticación, Estado Global | 🟡 Intermedia |
| **Stream** | Firebase Real-time, ToDo Sync | 🔴 Avanzada |

### 🌐 **Arquitectura Offline-First**

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Local SQLite  │◄──►│  Sync Service   │◄──►│  Firebase Cloud │
│   (Offline)     │    │  (Repository)   │    │   (Online)      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
        │                        │                        │
        │              ┌─────────────────┐                │
        └─────────────►│   UI Provider   │◄───────────────┘
                      └─────────────────┘
```

---

## 💻 Tecnologías

### 🎯 **Core Stack**

- **[Flutter](https://flutter.dev/)** `^3.24.5` - Framework UI multiplataforma
- **[Dart](https://dart.dev/)** `^3.3.0` - Lenguaje de programación
- **[Material Design 3](https://m3.material.io/)** - Sistema de diseño

### 🔥 **Backend & Database**

- **[Firebase Core](https://pub.dev/packages/firebase_core)** `^3.15.2` - Plataforma backend
- **[Cloud Firestore](https://pub.dev/packages/cloud_firestore)** `^5.6.12` - Base de datos NoSQL
- **[SQLite](https://pub.dev/packages/sqflite)** `^2.3.3` - Base de datos local
- **[HTTP](https://pub.dev/packages/http)** `^1.6.0` - Cliente HTTP

### 🗂️ **Gestión de Estado**

- **[Provider](https://pub.dev/packages/provider)** `^6.0.5` - Gestión de estado reactivo
- **[Streams](https://dart.dev/tutorials/language/streams)** - Programación reactiva nativa

### 🧭 **Navegación & Rutas**

- **[GoRouter](https://pub.dev/packages/go_router)** `^14.6.1` - Navegación declarativa type-safe

### 💾 **Almacenamiento & Persistencia**

- **[Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)** `^8.0.0` - Almacenamiento seguro
- **[Shared Preferences](https://pub.dev/packages/shared_preferences)** `^2.0.15` - Preferencias del usuario
- **[Path Provider](https://pub.dev/packages/path_provider)** `^2.1.3` - Rutas del sistema

### 🌐 **Conectividad & Sync**

- **[Connectivity Plus](https://pub.dev/packages/connectivity_plus)** `^6.0.5` - Detección de conectividad
- **[UUID](https://pub.dev/packages/uuid)** `^4.4.0` - Generación de identificadores únicos

### 🛠️ **Desarrollo & Testing**

- **[Flutter Lints](https://pub.dev/packages/flutter_lints)** `^5.0.0` - Linting y análisis estático
- **[Flutter Test](https://docs.flutter.dev/testing)** - Framework de testing integrado

---

## 📁 Estructura del Proyecto

```
lib/
├── 📱 main.dart                     # Punto de entrada de la aplicación
├── 🔥 firebase_options.dart         # Configuración Firebase
│
├── 🎨 themes/                       # Temas y estilos
│   └── app_theme.dart
│
├── 🧭 routes/                       # Configuración de rutas
│   └── app_router.dart              # GoRouter configuration
│
├── 📊 models/                       # Modelos de datos
│   ├── meal.dart                    # Modelo de comidas
│   └── categoria_fb.dart            # Modelo categorías Firebase
│
├── 🔧 services/                     # Servicios y APIs
│   ├── auth_service.dart            # Autenticación
│   ├── api_service.dart             # Cliente HTTP
│   └── categoria_service.dart       # CRUD categorías
│
├── 🏪 providers/                    # Gestores de estado (Provider)
│   └── auth_provider.dart           # Estado de autenticación
│
├── 🖼️ views/                        # Pantallas de la aplicación
│   ├── auth/                        # Autenticación
│   │   ├── login_screen.dart
│   │   └── evidence_screen.dart
│   │
│   ├── home/                        # Pantalla principal
│   │   └── home_screen.dart
│   │
│   ├── ciclo_vida/                  # Demo ciclo de vida
│   │   └── ciclo_vida_screen.dart
│   │
│   ├── async_demo/                  # Demos asíncronas
│   │   └── async_demo_screen.dart
│   │
│   ├── timer_demo/                  # Demo Timer
│   │   └── timer_demo_screen.dart
│   │
│   ├── isolate_demo/                # Demo Isolates
│   │   └── isolate_demo_screen.dart
│   │
│   ├── categoria_fb/                # Gestión categorías Firebase
│   │   ├── categoria_fb_list_view.dart
│   │   └── categoria_fb_form_view.dart
│   │
│   └── paso_parametros/             # Demo navegación con parámetros
│       ├── paso_parametros_screen.dart
│       └── detalle_screen.dart
│
├── 🧩 widgets/                      # Widgets reutilizables
│   ├── custom_appbar.dart
│   └── custom_drawer.dart
│
├── 🛠️ utils/                        # Utilidades y helpers
│
└── ✅ todo/                         # Módulo ToDo (Offline-First)
    ├── 📊 models/
    │   └── task.dart                # Modelo de tareas
    │
    ├── 🗄️ data/
    │   ├── local_data_source.dart   # SQLite local
    │   ├── remote_data_source.dart  # Firebase remoto
    │   └── task_repository.dart     # Repository pattern
    │
    ├── 🔧 services/
    │   └── sync_service.dart        # Servicio sincronización
    │
    ├── 🏪 providers/
    │   └── task_provider.dart       # Estado de tareas
    │
    ├── 🖼️ views/
    │   └── simple_todo_screen.dart  # UI ToDo app
    │
    └── 🧩 widgets/
        └── task_widgets.dart        # Widgets específicos ToDo
```

### 📂 **Descripción de Capas**

#### 🖼️ **Presentation Layer (Views + Widgets)**
- **Responsabilidad:** Interfaz de usuario, manejo de eventos, navegación
- **Tecnologías:** Flutter Widgets, Material Design 3, GoRouter
- **Patrón:** MVVM con Provider para gestión de estado

#### 🏪 **State Management Layer (Providers)**
- **Responsabilidad:** Gestión de estado reactivo, lógica de presentación
- **Tecnologías:** Provider, ChangeNotifier, Stream
- **Patrón:** Observer pattern para notificación de cambios

#### 🔧 **Service Layer (Services)**
- **Responsabilidad:** Lógica de negocio, comunicación con APIs externas
- **Tecnologías:** HTTP, Firebase SDK, Dart async/await
- **Patrón:** Service pattern, Dependency Injection

#### 🗄️ **Data Layer (Repository + Data Sources)**
- **Responsabilidad:** Acceso a datos, sincronización, caché
- **Tecnologías:** SQLite, Firestore, Secure Storage
- **Patrón:** Repository pattern, Strategy pattern para data sources

---

## 🚀 Instalación y Configuración

### 📋 **Prerrequisitos**

- ✅ **Flutter SDK** `>=3.3.0` ([Instalar Flutter](https://docs.flutter.dev/get-started/install))
- ✅ **Dart SDK** `>=3.3.0` (incluido con Flutter)
- ✅ **Android Studio** / **VS Code** con extensiones Flutter
- ✅ **Git** para control de versiones
- ✅ **Firebase CLI** (opcional, para despliegue)

### 🔍 **Verificar Instalación**

```bash
# Verificar Flutter
flutter doctor

# Verificar versiones
flutter --version
dart --version
```

### 📥 **Clonar Repositorio**

```bash
# Clonar el proyecto
git clone https://github.com/Felipe-Marulanda/TalleresEnClaseMoviles.git
cd TalleresEnClaseMoviles/talleres_moviles

# Verificar rama actual
git branch
```

### 📦 **Instalación de Dependencias**

```bash
# Instalar dependencias
flutter pub get

# Verificar dependencias desactualizadas (opcional)
flutter pub outdated

# Actualizar dependencias (opcional)
flutter pub upgrade
```

### 🔥 **Configuración Firebase**

#### 1. **Configuración Automática (Recomendado)**
El proyecto ya incluye `firebase_options.dart` configurado para desarrollo:

```dart
// lib/firebase_options.dart - Ya configurado
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'demo-api-key',
  projectId: 'talleres-moviles-demo',
  // ... configuración completa
);
```

#### 2. **Configuración Personalizada (Opcional)**

Si quieres usar tu propio proyecto Firebase:

```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Login a Firebase
firebase login

# Configurar proyecto
flutterfire configure
```

### 🏃‍♂️ **Habilitar Modo Desarrollador (Windows)**

En Windows, para soporte de symlinks requerido por Flutter:

```bash
# Abrir configuración desarrollador
start ms-settings:developers
```

**Activar:** `Modo de desarrollador` → ON

---

## ▶️ Ejecución

### 🌐 **Web (Recomendado para testing)**

```bash
# Ejecutar en Chrome
flutter run -d chrome

# O usar navegador específico
flutter run -d web-server --web-port 8080
```

### 📱 **Android**

```bash
# Listar dispositivos disponibles
flutter devices

# Ejecutar en dispositivo/emulador Android
flutter run -d android
```

### 🖥️ **Windows/macOS/Linux**

```bash
# Ejecutar en desktop
flutter run -d windows  # Windows
flutter run -d macos    # macOS
flutter run -d linux    # Linux
```

### 🔧 **Desarrollo con Hot Reload**

```bash
# Ejecutar en modo debug (hot reload habilitado)
flutter run

# En la terminal, usar:
# r - Hot reload
# R - Hot restart
# q - Quit
# o - Lista de comandos
```

### 🚀 **Build para Producción**

```bash
# Build para Web
flutter build web

# Build para Android
flutter build apk --release
flutter build appbundle --release

# Build para Windows
flutter build windows --release
```

---

## 🧪 Testing Offline y Sincronización

### 🌐 **Testing del Modo Offline**

#### **1. Probar ToDo App Offline-First**

```bash
# 1. Ejecutar la aplicación
flutter run -d chrome

# 2. Navegar a "ToDo App" en el menú lateral
# 3. Crear algunas tareas mientras tienes internet
# 4. Simular pérdida de conexión
```

#### **2. Simular Desconexión**

**En Chrome DevTools:**
1. Presiona `F12` para abrir DevTools
2. Ve a la pestaña **Network**
3. Selecciona **Offline** en el dropdown de throttling
4. Alternativamente, selecciona **Slow 3G** para simular conexión lenta

**En la aplicación:**
- ✅ Las tareas existentes deben seguir siendo visibles
- ✅ Debes poder crear nuevas tareas (se guardan localmente)
- ✅ Debes poder marcar/desmarcar tareas como completadas
- ✅ La UI debe mostrar indicador de estado offline

#### **3. Testing de Sincronización**

```bash
# 1. Con la app offline, crear/modificar varias tareas
# 2. Volver a habilitar conexión en DevTools
# 3. Observar la sincronización automática
```

**Comportamiento esperado:**
- 🔄 Sincronización automática al restaurar conexión
- ✅ Tareas locales se suben a Firebase
- ✅ Cambios remotos se descargan automáticamente
- 🔍 Resolución de conflictos (último cambio gana)

### 📊 **Testing de Estados de Gestión**

#### **setState() Demo - Ciclo de Vida**
```bash
# Navegar a: Menú → Ciclo de Vida
# Testing:
# - Incrementar contador (setState)
# - Observar logs en debug console
# - Verificar reconstrucción de widgets
```

#### **Provider Demo - Autenticación**
```bash
# Navegar a: Menú → Iniciar sesión
# Testing:
# - Login/logout con Provider
# - Estado persiste entre pantallas
# - Cambios se reflejan globalmente
```

#### **Stream Demo - Firebase Real-time**
```bash
# Navegar a: Menú → Categorías Firebase
# Testing:
# - Crear categoría (se refleja inmediatamente)
# - Abrir en otra pestaña/dispositivo
# - Verificar actualización en tiempo real
```

### 🔧 **Debugging y Logs**

#### **Habilitar Logs Detallados**

```bash
# Ejecutar con logs verbosos
flutter run --verbose

# Filtrar logs específicos
flutter logs | grep "TodoApp"
```

#### **Verificar Base de Datos Local**

```bash
# Los datos SQLite se almacenan en:
# Web: IndexedDB del navegador
# Android: /data/data/com.example.parqueadero_2025_g2/databases/
# Windows: %USERPROFILE%\\AppData\\Roaming\\com.example\\parqueadero_2025_g2\\
```

### 📱 **Testing en Dispositivos Múltiples**

```bash
# Terminal 1: Dispositivo Android
flutter run -d android

# Terminal 2: Web Chrome  
flutter run -d chrome

# Terminal 3: Windows Desktop
flutter run -d windows

# Testing:
# 1. Hacer cambios en un dispositivo
# 2. Verificar sincronización en otros dispositivos
# 3. Probar offline/online en cada plataforma
```

### 🎯 **Casos de Prueba Específicos**

#### **Scenario 1: Offline Creation + Online Sync**
1. 📱 Iniciar app con conexión
2. 🔌 Desconectar internet
3. ➕ Crear 3 tareas nuevas
4. ✏️ Editar 2 tareas existentes
5. 🔌 Reconectar internet
6. ✅ Verificar que todos los cambios se sincronizaron

#### **Scenario 2: Conflict Resolution**
1. 📱 Dispositivo A: Editar tarea "X"
2. 💻 Dispositivo B (offline): Editar la misma tarea "X"
3. 🔌 Dispositivo B: Reconectar
4. ✅ Verificar resolución de conflicto (último cambio gana)

#### **Scenario 3: Network Interruption During Sync**
1. 📱 Crear varias tareas offline
2. 🔌 Conectar internet (iniciar sync)
3. 🔌 Desconectar durante sincronización
4. ✅ Verificar que no se pierden datos
5. 🔌 Reconectar y completar sync

---

## 📱 Funcionalidades

### 🏠 **Pantalla Principal**
- ✅ Navegación principal con Material Design 3
- ✅ Drawer navigation con íconos descriptivos
- ✅ Vista de bienvenida con imagen de fondo

### 🔐 **Autenticación (Provider Demo)**
- ✅ Login/logout con gestión de estado Provider
- ✅ Persistencia de sesión con Secure Storage
- ✅ Estados de carga y error manejados

### 📋 **ToDo App (Offline-First)**
- ✅ **CRUD completo** de tareas
- ✅ **Modo offline** con SQLite local
- ✅ **Sincronización automática** con Firebase
- ✅ **Detección de conectividad** inteligente
- ✅ **Resolución de conflictos** automatizada
- ✅ **Estados visuales** (online/offline/syncing)

### 🔥 **Categorías Firebase (Real-time)**
- ✅ **Stream real-time** con Firestore
- ✅ **CRUD completo** de categorías empresariales
- ✅ **Validación de formularios** robusta
- ✅ **UI responsiva** con Material Design 3

### 🔄 **Demos de Gestores de Estado**
- ✅ **setState()**: Ciclo de vida de widgets
- ✅ **Provider**: Estado global reactivo
- ✅ **Stream**: Datos en tiempo real
- ✅ **Timer**: Programación asíncrona
- ✅ **Isolate**: Computación en background

### 🧭 **Navegación Avanzada**
- ✅ **GoRouter** con rutas type-safe
- ✅ **Paso de parámetros** por URL y objeto
- ✅ **Deep linking** habilitado
- ✅ **Navegación programática**

### 🎨 **UI/UX Features**
- ✅ **Material Design 3** con tema personalizado
- ✅ **Responsive design** para múltiples dispositivos
- ✅ **Animaciones fluidas** y transiciones
- ✅ **Dark/Light theme** support
- ✅ **Accessibility** features implementadas

---

## 🎨 Capturas de Pantalla

### 🏠 **Pantalla Principal**
*Interfaz principal con navegación Material Design 3 y drawer personalizado*

![Pantalla Principal](Captura%20de%20pantalla%202025-10-10%20012455.png)

*Vista de la pantalla principal mostrando el drawer de navegación y la interfaz Material Design 3*

### 📋 **ToDo App - Offline First**
*Aplicación ToDo con funcionalidad offline-first y sincronización automática*

![ToDo App - Lista de Tareas](Captura%20de%20pantalla%202025-11-18%20124726.png)

*Vista principal del ToDo mostrando lista de tareas con indicadores de estado*

![ToDo App - Gestión de Tareas](Captura%20de%20pantalla%202025-11-18%20124756.png)

*Interfaz para crear y editar tareas con validación en tiempo real*

### 🔥 **Firebase Real-time & Navegación**
*Demostración de diferentes pantallas y funcionalidades de la app*

![Firebase Categories & Navigation](Captura%20de%20pantalla%202025-11-18%20124804.png)

*Vista de categorías Firebase y navegación entre diferentes demos de gestores de estado*

### 🎯 **Características Destacadas**

<div align="center">

| 🏠 **Home Screen** | 📋 **ToDo Management** | 🔥 **Firebase Integration** |
|:------------------:|:---------------------:|:---------------------------:|
| • Material Design 3<br>• Drawer Navigation<br>• Responsive Layout | • Offline-First Storage<br>• Auto-Sync<br>• Real-time Updates | • Firestore Real-time<br>• Authentication<br>• Cloud Sync |

</div>

### 📱 **Funcionalidades Demostradas**

#### ✅ **ToDo App - Arquitectura Offline-First**
- **Almacenamiento Local:** SQLite para persistencia offline
- **Sincronización:** Automática cuando hay conectividad
- **Estados Visuales:** Indicadores de online/offline/syncing
- **CRUD Completo:** Crear, leer, actualizar y eliminar tareas

#### 🔄 **Gestores de Estado Implementados**
- **setState():** Para ciclo de vida de widgets
- **Provider:** Para estado global y autenticación  
- **Stream:** Para datos en tiempo real con Firebase
- **Repository Pattern:** Para gestión de datos offline/online

#### 🧭 **Navegación Avanzada**
- **GoRouter:** Navegación declarativa type-safe
- **Deep Linking:** URLs navegables
- **Parámetros:** Por ruta y objeto
- **Material Navigation:** Drawer y bottom navigation

### 💻 **Compatibilidad Multiplataforma**

<table>
  <tr>
    <td align="center">
      <b>🌐 Web (Chrome)</b><br>
      <i>Funcionalidad completa<br>IndexedDB para offline</i>
    </td>
    <td align="center">
      <b>📱 Android/iOS</b><br>
      <i>Nativo optimizado<br>SQLite local</i>
    </td>
    <td align="center">
      <b>🖥️ Desktop</b><br>
      <i>Windows/macOS/Linux<br>Almacenamiento local</i>
    </td>
  </tr>
</table>

---

## 🧪 Testing

### 🔍 **Análisis Estático**

```bash
# Ejecutar linter
flutter analyze

# Verificar formato
dart format --set-exit-if-changed .

# Fix automático de issues menores
dart fix --apply
```

### 🧪 **Unit Tests**

```bash
# Ejecutar todos los tests
flutter test

# Tests con cobertura
flutter test --coverage

# Test específico
flutter test test/models/task_test.dart
```

### 📱 **Integration Tests**

```bash
# Tests de integración
flutter drive --target=test_driver/app.dart
```

### 📊 **Performance Testing**

```bash
# Profiling de performance
flutter run --profile --trace-startup

# Análisis de memoria
flutter run --profile --trace-systrace
```

---

## 🚀 Deployment

### 📦 **Preparación para Release**

```bash
# Actualizar versión en pubspec.yaml
version: 1.0.1+2

# Build release
flutter build web --release
flutter build apk --release
flutter build windows --release
```

### 🔥 **Firebase Hosting (Web)**

```bash
# Build web
flutter build web

# Deploy a Firebase
firebase deploy --only hosting
```

### 📱 **Google Play Store (Android)**

```bash
# Build app bundle
flutter build appbundle --release

# Upload a Play Console
# Seguir guía oficial: https://docs.flutter.dev/deployment/android
```

### 🍎 **App Store (iOS)**

```bash
# Build iOS
flutter build ios --release

# Usar Xcode para upload a App Store
```

---

## 🤝 Contribución

### 🐛 **Reportar Issues**

1. Ir a [Issues](https://github.com/Felipe-Marulanda/TalleresEnClaseMoviles/issues)
2. Crear nuevo issue con template
3. Incluir información de reproducción

### 💡 **Contribuir Código**

```bash
# 1. Fork del repositorio
# 2. Crear rama feature
git checkout -b feature/nueva-funcionalidad

# 3. Hacer cambios y commits
git commit -m \"feat: agregar nueva funcionalidad\"

# 4. Push y crear Pull Request
git push origin feature/nueva-funcionalidad
```

### 📋 **Convenciones**

- **Commits:** Seguir [Conventional Commits](https://www.conventionalcommits.org/)
- **Código:** Seguir [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- **Testing:** Cubrir nuevas funcionalidades con tests

---

## 📚 Recursos Adicionales

### 📖 **Documentación**
- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Flutter Documentation](https://firebase.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [GoRouter Documentation](https://pub.dev/packages/go_router)

### 🎓 **Tutoriales y Guías**
- [Flutter Offline-First Apps](https://flutter.dev/docs/cookbook/persistence)
- [Firebase with Flutter](https://firebase.google.com/docs/flutter/setup)
- [State Management in Flutter](https://docs.flutter.dev/development/data-and-backend/state-mgmt)

### 🛠️ **Herramientas de Desarrollo**
- [Flutter Inspector](https://docs.flutter.dev/development/tools/flutter-inspector)
- [Firebase Console](https://console.firebase.google.com/)
- [Android Studio](https://developer.android.com/studio)
- [VS Code Flutter Extensions](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

---

## 📄 Licencia

Este proyecto está licenciado bajo la **MIT License** - ver el archivo [LICENSE](LICENSE) para detalles.

---

## 👥 Autores y Colaboradores

- **Felipe Marulanda** - *Desarrollo Principal* - [@Felipe-Marulanda](https://github.com/Felipe-Marulanda)

### 🎓 **Contexto Académico**
- **Universidad:** UCEVA (Unidad Central del Valle del Cauca)
- **Curso:** Desarrollo de Aplicaciones Móviles
- **Año:** 2025
- **Grupo:** G2

---

## 🙏 Agradecimientos

- **Firebase Team** por la excelente documentación y herramientas
- **Flutter Community** por los packages y recursos
- **Material Design Team** por las guías de diseño
- **Comunidad de Desarrolladores** por el feedback y contribuciones

---

<div align="center">

**⭐ Si este proyecto te fue útil, ¡déjanos una estrella en GitHub! ⭐**

[![GitHub stars](https://img.shields.io/github/stars/Felipe-Marulanda/TalleresEnClaseMoviles?style=social)](https://github.com/Felipe-Marulanda/TalleresEnClaseMoviles/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Felipe-Marulanda/TalleresEnClaseMoviles?style=social)](https://github.com/Felipe-Marulanda/TalleresEnClaseMoviles/network/members)

---

**💻 Desarrollado con ❤️ usando Flutter y Firebase**

**📱 Compatible con Web • Android • iOS • Windows • macOS • Linux**

</div>
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
