# Capturas Requeridas para Evidencias

## Firebase Console
1. `firebase_releases_v1.0.0.png` - Panel de Releases mostrando versión 1.0.0
2. `firebase_testers_grupo.png` - Configuración del grupo QA_Clase  
3. `firebase_tester_agregado.png` - Tester dduran@uceva.edu.co agregado al grupo
4. `firebase_distribucion_exitosa.png` - Mensaje de distribución exitosa
5. `firebase_releases_antes.png` - Panel antes de actualización (solo 1.0.0)
6. `firebase_releases_despues.png` - Panel después de actualización (1.0.0 y 1.0.1)

## Evidencias de Tester
7. `correo_invitacion_tester.png` - Screenshot del correo de invitación recibido
8. `app_instalada_dispositivo.jpg` - Foto del dispositivo con la app instalada
9. `app_pantalla_principal.jpg` - Foto de la pantalla principal funcionando
10. `notificacion_actualizacion.png` - Screenshot de notificación de nueva versión

# 📸 Capturas de Pantalla - Categorías Firebase

Este directorio contiene las capturas de pantalla que documentan la implementación del módulo de Categorías Firebase.

## 📋 Índice de Capturas

### 1. 🔸 Consola de Firebase
- **Archivo:** `firebase_console.png`
- **Descripción:** Muestra la colección "categorias" en Firestore con los documentos y campos implementados
- **Datos mostrados:** 
  - Colección "categorias" activa
  - Documento de UCEVA con campos: nit, nombre, direccion, telefono, pagina_web
  - Estructura de datos correctamente implementada

### 2. 🔸 Lista de Categorías (Aplicación Móvil)
- **Archivo:** `lista_categorias.png` 
- **Descripción:** Vista principal del listado de categorías en la aplicación
- **Características mostradas:**
  - Cards con información de empresas (Universidad del Valle, UCEVA)
  - Campos: Nombre, NIT, dirección, teléfono
  - Iconografía: Iconos de empresa, ubicación, teléfono
  - Botón flotante "Nueva" 
  - Botones de eliminación por elemento
  - Diseño Material Design 3

### 3. 🔸 Formulario de Edición
- **Archivo:** `formulario_edicion.png`
- **Descripción:** Pantalla de edición/creación de categorías
- **Campos mostrados:**
  - **NIT:** Campo con icono de identificación
  - **Nombre:** Campo con icono de empresa
  - **Dirección:** Campo con icono de ubicación
  - **Teléfono:** Campo con icono de teléfono
  - **Página Web:** Campo con icono de web
  - Botones "Guardar" y "Cancelar"
  - Datos pre-cargados de UCEVA para edición

### 4. 🔸 Menú de Navegación
- **Archivo:** `menu_principal.png`
- **Descripción:** Panel lateral de navegación de la aplicación
- **Elementos mostrados:**
  - Menú lateral completo
  - Opción "Categorías Firebase" destacada
  - Otras opciones: Inicio, Configuración, Perfil, etc.
  - Diseño Material Design 3 consistente

## 🎯 Propósito de las Capturas

Estas capturas sirven como **evidencia técnica** de:

1. **✅ Configuración exitosa de Firebase**
   - Conexión establecida con Firestore
   - Colección "categorias" creada y funcional
   - Documentos con estructura correcta

2. **✅ Implementación completa del módulo**
   - CRUD funcional (Create, Read, Update, Delete)
   - Interfaz de usuario moderna y responsiva
   - Validaciones implementadas

3. **✅ Experiencia de usuario optimizada**
   - Navegación intuitiva
   - Formularios bien diseñados
   - Información clara y accesible

4. **✅ Arquitectura técnica sólida**
   - Integración Flutter + Firebase
   - Material Design 3
   - Responsive design

## 📱 Información Técnica

- **Plataforma de prueba:** Web (Chrome)
- **Resolución:** Responsiva (mobile-first)
- **Framework:** Flutter 3.24.5
- **Base de datos:** Firebase Firestore
- **Diseño:** Material Design 3

## 🔗 Archivos Relacionados

- [`EVIDENCIAS_CATEGORIAS_FIREBASE.md`](../EVIDENCIAS_CATEGORIAS_FIREBASE.md) - Documentación completa
- [`EVIDENCIAS_CATEGORIAS_FIREBASE.html`](../EVIDENCIAS_CATEGORIAS_FIREBASE.html) - Versión HTML para PDF
- Código fuente en `lib/views/categoria_fb/`

---

**📋 Última actualización:** 4 de Noviembre, 2025  
**👨‍💻 Desarrollador:** Felipe Marulanda  
**📂 Proyecto:** TalleresEnClaseMoviles

### Firebase Console:
- Usar navegador en modo normal (no privado)
- Mostrar claramente nombres de versiones y fechas
- Incluir la barra superior de Firebase en las capturas
- Asegurar que se vea el nombre del proyecto

### Dispositivo Android:
- Usar dispositivo físico si es posible
- Mostrar la app completamente abierta y funcional
- Incluir la barra de estado del dispositivo
- Buena iluminación y enfoque en las fotos

### Formato de archivos:
- PNG para capturas de pantalla
- JPG para fotos de dispositivo
- Resolución mínima: 720p
- Tamaño máximo: 5MB por imagen