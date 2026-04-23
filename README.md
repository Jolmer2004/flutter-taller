* Datos Abiertos Colombia — Flutter

Estudiantes: Jolmer Alexander Viedma Agudelo

Aplicación Flutter que consume la API pública api-colombia.com mostrando información geográfica y turística del país mediante Dashboard, Listado y Detalle.

---

* Dashboard

1. El usuario abre la app y ve 4 cards temáticas.
2. Cada card muestra un icono, título y subtítulo del endpoint.
3. Al tocar una card, go_router navega a "/list/:endpoint".


* Listado — "ListView.builder" ("/list/:endpoint")

- La vista recibe el "endpoint" como path parameter de go_router.
- "ApiService" realiza el "GET" a "https://api-colombia.com/api/v1/{endpoint}".
- "FutureBuilder" gestiona tres estados:
  - **Cargando: "CircularProgressIndicator" + texto "Cargando datos..."
  - **Error: icono "wifi_off" + mensaje + botón *Volver al inicio*
  - Éxito: contador de resultados + "ListView.builder" con cada ítem
- Al tocar un ítem, navega a "/detail" pasando el Map JSON completo via "extra".

* Detalle — Maestro-Detalle ("/detail")

1. El usuario toca un ítem del listado.
2. "go_router" recibe el "Map<String, dynamic>" completo via "extra".
3. La vista itera sobre las claves del JSON y muestra cada campo del registro.
