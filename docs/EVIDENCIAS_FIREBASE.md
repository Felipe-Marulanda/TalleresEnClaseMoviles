# Evidencias Firebase - Módulo Universidades

Este documento contiene la evidencia técnica del módulo Firebase para gestión de universidades, desarrollado como parte del taller de desarrollo móvil.

---

## 📋 Resumen del Módulo

**Objetivo:** Desarrollar un módulo en Flutter que integre Firebase y cree/gestione la colección `universidades` con operaciones CRUD en tiempo real.

**Tecnologías:**
- Flutter 3.3.0+
- Firebase Core 3.15.2
- Cloud Firestore 5.6.12
- Provider para gestión de estado
- GoRouter para navegación

---

## 🏗️ Arquitectura Implementada

### Estructura de Archivos

```
lib/
├── firebase_options.dart           # Configuración Firebase
├── models/
│   └── universidad.dart           # Modelo de datos Universidad
├── services/
│   └── universidad_service.dart   # Servicio CRUD Firebase
├── views/universidades/
│   ├── universidades_screen.dart  # Listado con Stream en tiempo real
│   └── nueva_universidad_screen.dart # Formulario de creación
└── routes/
    └── app_router.dart            # Rutas: /universidades, /nueva_universidad
```

### Modelo de Datos

**Colección Firestore:** `universidades`

**Estructura del Documento:**
```json
{
  "nit": "890.123.456-7",
  "nombre": "Universidad Central del Valle",
  "direccion": "Cra 27A #48-144, Tuluá - Valle",
  "telefono": "+57 602 2242202",
  "pagina_web": "https://www.uceva.edu.co"
}
```

**Modelo Dart:** 
- Campos: `id`, `nit`, `nombre`, `direccion`, `telefono`, `paginaWeb`
- Métodos: `toMap()`, `fromMap()`, `copyWith()`
- Validaciones: NIT, teléfono y URL

---

## 🔧 Funcionalidades Implementadas

### 1. Conexión Firebase
- ✅ Inicialización en `main.dart`
- ✅ Configuración multiplataforma (`firebase_options.dart`)
- ✅ Integración con Cloud Firestore

### 2. Operaciones CRUD

**Crear Universidad:**
- Formulario con validación de campos
- Verificación de NIT duplicado
- Guardado en Firestore

**Listar Universidades:**
- Stream en tiempo real de la colección
- Ordenamiento por nombre
- UI responsiva con estados de carga/error/vacío

**Eliminar Universidad:**
- Confirmación antes de eliminar
- Actualización inmediata en UI

### 3. Validaciones Implementadas

```dart
// Validación NIT
final nitRegex = RegExp(r'^\d{3,9}[-.]?\d{1}$');

// Validación Teléfono  
final phoneRegex = RegExp(r'^[\+]?[\d\s\-\(\)]{7,15}$');

// Validación URL
final uri = Uri.parse(value);
if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
  return 'URL inválida';
}
```

### 4. UI/UX

**Pantalla Principal (`/universidades`):**
- Lista en tiempo real con StreamBuilder
- Cards con información resumida
- Botón flotante para agregar
- Menú contextual para eliminar
- Estados: loading, error, vacío, con datos

**Formulario (`/nueva_universidad`):**
- Validación en tiempo real
- Campos requeridos marcados
- Feedback visual (loading, errores)
- Cancelar/Guardar con confirmación

---

## 🛠️ Comandos de Prueba

### Setup del Proyecto
```bash
# Instalar dependencias
flutter pub get

# Verificar configuración
flutter analyze

# Ejecutar en modo debug
flutter run

# Ejecutar tests
flutter test
```

### Probar el Módulo
1. Abrir la app en emulador/dispositivo
2. Ir al Drawer → "Universidades" 
3. Crear una nueva universidad con datos válidos
4. Verificar que aparece inmediatamente en la lista
5. Intentar crear con NIT duplicado (debe fallar)
6. Eliminar una universidad (con confirmación)

---

## 📊 Datos de Prueba Sugeridos

### Universidad 1
```
NIT: 890.123.456-7
Nombre: Universidad Central del Valle (UCEVA)
Dirección: Cra 27A #48-144, Tuluá - Valle del Cauca
Teléfono: +57 602 2242202
Página Web: https://www.uceva.edu.co
```

### Universidad 2
```
NIT: 860.006.502-1
Nombre: Universidad Nacional de Colombia
Dirección: Carrera 45 # 26-85, Bogotá D.C.
Teléfono: +57 1 3165000
Página Web: https://unal.edu.co
```

### Universidad 3
```
NIT: 890.302.228-1
Nombre: Universidad del Valle
Dirección: Calle 13 # 100-00, Cali - Valle del Cauca
Teléfono: +57 2 3212100
Página Web: https://www.univalle.edu.co
```

---

## 🔍 Puntos de Verificación para Evidencia

### Configuración Firebase
- [ ] Captura de `firebase_options.dart` configurado
- [ ] Captura de consola Firebase con proyecto creado
- [ ] Captura de dependencias en `pubspec.yaml`

### Funcionalidad CRUD
- [ ] Captura del listado vacío (estado inicial)
- [ ] Captura del formulario de nueva universidad
- [ ] Captura de validaciones fallando (campos vacíos/formatos incorrectos)
- [ ] Captura de universidad creada exitosamente
- [ ] Captura del listado con universidades (tiempo real)
- [ ] Captura de eliminación con confirmación

### Código Técnico
- [ ] Código del modelo `Universidad`
- [ ] Código del servicio `UniversidadService`
- [ ] Código del StreamBuilder en tiempo real
- [ ] Integración en el menú y rutas

### Firebase Console
- [ ] Captura de la colección `universidades` en Firestore
- [ ] Captura de documentos creados con datos
- [ ] Captura de métricas de uso (opcional)

---

## 🎯 Casos de Uso Probados

1. **Crear Universidad Válida**
   - ✅ Todos los campos completados correctamente
   - ✅ NIT en formato válido
   - ✅ URL con esquema http/https
   - ✅ Teléfono en formato internacional

2. **Validaciones de Campos**
   - ✅ Campos vacíos → Error mostrado
   - ✅ NIT inválido → Error de formato
   - ✅ URL sin esquema → Error de URL
   - ✅ NIT duplicado → Error de duplicación

3. **Stream en Tiempo Real**
   - ✅ Lista se actualiza automáticamente al crear
   - ✅ Lista se actualiza automáticamente al eliminar
   - ✅ Ordenamiento por nombre mantenido

4. **Manejo de Estados**
   - ✅ Loading durante operaciones Firebase
   - ✅ Error con mensaje descriptivo y botón reintentar
   - ✅ Estado vacío con call-to-action
   - ✅ Éxito con feedback inmediato

---

## 📝 Notas Técnicas

### Firebase Configuration
- Configuración de demo para desarrollo local
- Proyecto ID: `talleres-moviles-demo`
- Para producción: reemplazar con credenciales reales

### Consideraciones de Seguridad
- Rules de Firestore configuradas para desarrollo (permisivas)
- En producción: implementar autenticación y rules estrictas
- Validar datos tanto en cliente como en servidor

### Performance
- Stream optimizado con `orderBy('nombre')`
- Queries eficientes con indices automáticos
- UI responsiva con estados de carga

---

## 📎 Archivos de Código Relevantes

Ver los siguientes archivos para revisión técnica:

1. `lib/models/universidad.dart` - Modelo de datos
2. `lib/services/universidad_service.dart` - Servicio CRUD
3. `lib/views/universidades/universidades_screen.dart` - UI principal
4. `lib/views/universidades/nueva_universidad_screen.dart` - Formulario
5. `lib/firebase_options.dart` - Configuración Firebase
6. `pubspec.yaml` - Dependencias

---

*Documento generado: Noviembre 2025*  
*Rama: feature/taller_firebase_universidades*  
*Estado: Desarrollo completado*