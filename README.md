# 🎬 BiblioCine App
Aplicación móvil para la gestión y exploración de catálogos de películas, construida con un enfoque en escalabilidad y código limpio.

## 🛠️ Stack Tecnológico

Este proyecto utiliza las herramientas más modernas del ecosistema Flutter

* **Framework:** [Flutter](https://flutter.dev/)
* **Arquitectura:** Clean Architecture Pragmática (Capas: `Infrastructure`, `Domain`, `Presentation`).
* **Gestión de Estado:** [Riverpod Generator](https://riverpod.dev/) (Estado reactivo con seguridad de tipos).
* **Persistencia Local:** [Drift](https://drift.simonbinder.eu/) (Motor SQLite).
* **Networking:** [Dio](https://pub.dev/packages/dio) (Cliente HTTP robusto para APIs).
* **Navegación:** [GoRouter](https://pub.dev/packages/go_router) (Rutas declarativas y fuertemente tipadas).

## ⚙️ Instalación y Configuración

Para ejecutar este proyecto localmente:

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/VladimirOJDev/BiblioCine.git
   ```
2. Copiar el env.template y renombarlo a .env en la raíz del proyecto.
   ```bash
    env.template .env
    ```
4. Cambiar las variables de entorno (The MovieDB)
    ```bash
    MOVIE_DB_KEY=tu_api_key_aqui
    ```
5. nstalar dependencias y generar código:
   ```bash
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
    ```
6. Ejecutar la aplicación
   ```bash
    flutter run
    ```





