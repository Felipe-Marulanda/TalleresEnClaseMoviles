# Evidencias de Distribución - Firebase App Distribution

## Información del Proyecto
- **Proyecto**: Parqueadero 2025 G2  
- **Repositorio**: [TalleresEnClaseMoviles](https://github.com/Felipe-Marulanda/TalleresEnClaseMoviles)
- **Rama de trabajo**: `feature/app_distribution`
- **Responsable**: Felipe Marulanda
- **Fecha**: 20 de octubre de 2025

---

## 1. Configuración del Proyecto

### APK Generado
- **Archivo**: `app-release.apk`
- **Tamaño**: 108.4MB
- **Versión**: 1.0.0+1
- **Application ID**: `com.example.parqueadero_2025_g2`

### Comando utilizado:
```bash
flutter clean
flutter pub get
flutter build apk --release
```

---

## 2. Evidencias de Firebase App Distribution

### 2.1 Panel de Releases
![Panel Releases - Versión 1.0.0](capturas/firebase_releases_v1.0.0.png)

### 2.2 Configuración de Testers
![Grupo QA_Clase configurado](capturas/firebase_testers_grupo.png)
![Tester dduran@uceva.edu.co agregado](capturas/firebase_tester_agregado.png)

### 2.3 Distribución Exitosa
![APK distribuido exitosamente](capturas/firebase_distribucion_exitosa.png)

---

## 3. Evidencias de Recepción

### 3.1 Correo de Invitación
![Correo recibido por el tester](capturas/correo_invitacion_tester.png)

### 3.2 Instalación en Dispositivo
![App instalada en dispositivo Android](capturas/app_instalada_dispositivo.jpg)
![Pantalla principal funcionando](capturas/app_pantalla_principal.jpg)

---

## 4. Prueba de Actualización (1.0.0 → 1.0.1)

### 4.1 Antes de la Actualización
![Releases con versión 1.0.0](capturas/firebase_releases_antes.png)

### 4.2 Después de la Actualización  
![Releases con versión 1.0.1](capturas/firebase_releases_despues.png)

### 4.3 Notificación de Actualización
![Notificación de nueva versión](capturas/notificacion_actualizacion.png)

---

## 5. Bitácora de QA

### Versión 1.0.0
- **Fecha**: 20/10/2025
- **Estado**: ✅ Distribuido exitosamente
- **Funciones probadas**:
  - ✅ Navegación con GoRouter
  - ✅ Carga de datos desde API
  - ✅ Async, Isolate y Timer demos
  - ✅ Paso de parámetros

### Versión 1.0.1  
- **Fecha**: 20/10/2025
- **Cambios**: [Por definir]
- **Estado**: [Por probar]

### Incidencias Reportadas
1. **[ID]** - **[Descripción]** - **Estado**: [Resuelto/Pendiente]

---

## 6. Enlaces y Recursos

### Enlaces de Instalación
- **Versión 1.0.0**: [Enlace Firebase - Por agregar]
- **Versión 1.0.1**: [Enlace Firebase - Por agregar]

### Archivos de Distribución
- **release_info.txt**: Información detallada de la release
- **evidencias.pdf**: Documentación completa para entrega

---

## 7. Checklist de Evidencias

### Capturas de Firebase Console
- [ ] Panel Releases con versión visible
- [ ] Configuración de grupo QA_Clase  
- [ ] Tester dduran@uceva.edu.co agregado
- [ ] Mensaje de distribución exitosa
- [ ] Comparación antes/después actualización

### Evidencias de Usuario Final
- [ ] Correo de invitación recibido
- [ ] App instalada en dispositivo físico
- [ ] Pantallas principales funcionando
- [ ] Notificación de actualización

### Documentación
- [ ] release_info.txt creado
- [ ] Release notes detalladas
- [ ] Bitácora de QA completada
- [ ] PDF final generado

---

*Documento generado automáticamente para evidenciar el proceso de distribución con Firebase App Distribution*