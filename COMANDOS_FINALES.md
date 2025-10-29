# Comandos Finales - GitFlow y Entregables

## 🔄 Comandos Git para completar el flujo

### 1. Push de la rama feature
```powershell
git push origin feature/app_distribution
```

### 2. Crear Pull Request (GitHub Web)
- Ir a: https://github.com/Felipe-Marulanda/TalleresEnClaseMoviles
- **Compare & pull request**: `feature/app_distribution` → `dev`
- **Título**: `feat(distribucion): Firebase App Distribution implementado`
- **Descripción**: 
```
## Resumen
Implementación completa de distribución con Firebase App Distribution

## Cambios realizados
- ✅ APK v1.0.0 y v1.0.1 generados y distribuidos
- ✅ Configuración Firebase con grupo QA_Clase
- ✅ Tester dduran@uceva.edu.co agregado
- ✅ Documentación completa de evidencias
- ✅ release_info.txt con enlaces de instalación

## Archivos agregados/modificados
- `docs/EVIDENCIAS.md` - Documentación markdown
- `docs/evidencias.html` - Versión para PDF  
- `docs/capturas/README.md` - Lista de capturas
- `release_info.txt` - Info de releases
- `pubspec.yaml` - Actualización versión 1.0.1

## Enlaces de distribución
- v1.0.0: https://appdistribution.firebase.google.com/testerapps/1:797972785950:android:ce1a50fbb43de86aad370f/releases/6sd6bmod7jggg
- v1.0.1: https://appdistribution.firebase.google.com/testerapps/1:797972785950:android:ce1a50fbb43de86aad370f/releases/356v6u03i9r8o

## Checklist de pruebas
- [ ] Tester recibe correos de ambas versiones
- [ ] Instalación exitosa en dispositivo Android
- [ ] Navegación y funciones principales operativas
- [ ] Proceso de actualización 1.0.0 → 1.0.1 funcional
```

### 3. Después del merge a dev, actualizar dev local
```powershell
git checkout dev
git pull origin dev
```

### 4. Merge dev → main
```powershell
git checkout main  
git pull origin main
git merge dev
git push origin main
```

### 5. Verificar estado final
```powershell
git log --oneline -10
git remote -v
```

## 📄 Generar PDF de evidencias

### Opción 1: Desde el navegador
1. Abrir: `file:///C:/Users/castr/OneDrive/Escritorio/TALLERES_MOVILES/talleres_moviles/docs/evidencias.html`
2. **Ctrl + P** → **Guardar como PDF**
3. Configuración:
   - Orientación: Vertical
   - Páginas: Todas
   - Márgenes: Normales
4. Guardar como: `evidencias.pdf`

### Opción 2: Desde VS Code
1. Instalar extensión "Markdown PDF"
2. Abrir `docs/EVIDENCIAS.md`
3. **Ctrl + Shift + P** → "Markdown PDF: Export (pdf)"

## 📋 Checklist final de entregables

### Repositorio Git
- [ ] Rama `feature/app_distribution` pusheada
- [ ] Pull Request creado y mergeado a `dev`
- [ ] `dev` mergeado a `main`
- [ ] Ambas ramas (`dev` y `main`) actualizadas

### Archivos de evidencia
- [ ] `release_info.txt` con enlaces de ambas versiones
- [ ] `docs/EVIDENCIAS.md` completo
- [ ] `docs/evidencias.html` listo para PDF
- [ ] `evidencias.pdf` generado

### Capturas requeridas (docs/capturas/)
- [ ] `firebase_releases_antes.png` - Solo v1.0.0
- [ ] `firebase_releases_despues.png` - v1.0.0 y v1.0.1
- [ ] `firebase_testers_grupo.png` - Grupo QA_Clase
- [ ] `firebase_tester_agregado.png` - dduran@uceva.edu.co
- [ ] `correo_invitacion_tester.png` - Email recibido
- [ ] `app_instalada_dispositivo.jpg` - App funcionando
- [ ] `notificacion_actualizacion.png` - Update notification

### Validación final
- [ ] Enlaces de instalación funcionan
- [ ] Tester puede instalar ambas versiones
- [ ] Documentación completa y legible
- [ ] PDF imprimible generado

## 🧪 Tests y GitFlow para auth (nuevas adiciones)

### Ejecutar tests rápidos
```powershell
flutter pub get
flutter test test/auth_provider_test.dart
flutter test test/login_screen_test.dart
```

### Crear rama para trabajo de auth y abrir PR
```powershell
git checkout -b feature/taller_jwt
git add .
git commit -m "feat(auth): add JWT client, provider and UI"
git push origin feature/taller_jwt
```

### Pull request
- Abrir PR `feature/taller_jwt` -> `dev` con descripción del cambio: login, secure storage, AppHttpClient, tests.


## 🎯 URLs importantes

- **Repositorio**: https://github.com/Felipe-Marulanda/TalleresEnClaseMoviles
- **Firebase Project**: https://console.firebase.google.com/project/[project-id]
- **Instalación v1.0.0**: https://appdistribution.firebase.google.com/testerapps/1:797972785950:android:ce1a50fbb43de86aad370f/releases/6sd6bmod7jggg
- **Instalación v1.0.1**: https://appdistribution.firebase.google.com/testerapps/1:797972785950:android:ce1a50fbb43de86aad370f/releases/356v6u03i9r8o

---