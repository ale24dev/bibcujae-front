# Sistema de gestión bibliotecaria para la CUJAE
Este es un proyecto de front-end desarrollado en Flutter Web para la creación de un sistema de gestión bibliotecaria para la CUJAE (Universidad Tecnológica de La Habana "José Antonio Echeverría").

## Descripción
El objetivo de este proyecto es crear una interfaz de usuario intuitiva y fácil de usar para los estudiantes y profesores de la CUJAE que necesitan buscar y reservar libros en la biblioteca. La aplicación también permitirá a los administradores de la biblioteca administrar y mantener el inventario de libros y gestionar las reservas y préstamos.

## Características
- Búsqueda de libros por título, autor o categoría
- Reserva de libros en línea
- Administración del inventario de libros
- Administración de reservas y préstamos
- Perfiles de usuario personalizados para estudiantes, profesores y administradores
- Integración con el sistema de autenticación de la CUJAE

## Tecnologías utilizadas

- Flutter 3.7.1
- Dart 2.19.1

## Cómo ejecutar el proyecto

Clone el repositorio en su máquina local
```shell
git clone https://github.com/ale24dev/bibcujae-front.git
```

Ejecute el siguiente comando para instalar las dependencias:
```shell
flutter pub get
```

Inicie el servidor de desarrollo con el siguiente comando:
```shell
flutter run -d web-server --web-port=8080 --web-hostname=127.0.0.1
```
```shell
http://localhost:8080/
```

