TALLLER HTTP

}Descripción

Este proyecto es una aplicación Flutter que consume una API para mostrar platos de comida. Permite ver un listado de platos, detalles de cada plato y manejar estados de carga o error.

API

Endpoint principal: GET https://tuapi.com/platos

Ejemplo de respuesta JSON:

[
  {
    "id": 1,
    "nombre": "Spaghetti Bolognesa",
    "descripcion": "Deliciosa pasta con salsa de carne",
    "imagen": "https://linkaimagen.com/spaghetti.jpg"
  },
  {
    "id": 2,
    "nombre": "Ensalada César",
    "descripcion": "Fresca ensalada con aderezo César",
    "imagen": "https://linkaimagen.com/ensalada.jpg"
  }
]

Arquitectura
lib/
 ├─ models/      # Definición de clases de datos (Plato, Usuario, etc.)
 ├─ services/    # Lógica para consumir la API
 ├─ views/       # Pantallas de la app (Home, Detalle, etc.)
 ├─ config/      # Configuraciones globales (URLs, constantes)

Rutas con go_router

/ → Pantalla principal con listado de platos.

/detalle/:id → Pantalla de detalle de plato.
Parámetros enviados: id del plato.

Ejemplo de navegación:

context.go('/detalle/${plato.id}');

Estados

Carga: Indicador mientras se reciben datos.

Error: Mensaje si falla la petición a la API.

Vacío: Mensaje si no hay datos disponibles.

Capturas
<img width="1914" height="954" alt="Captura de pantalla 2025-10-10 012455" src="https://github.com/user-attachments/assets/2fe34e1d-1d96-4bfb-b88d-ed558fc73a3a" />
<img width="1913" height="1072" alt="Captura de pantalla 2025-10-10 012520" src="https://github.com/user-attachments/assets/61325dc4-e625-48e2-8728-4ef4c7744e74" />
