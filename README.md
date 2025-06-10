# ResidentEvilWiki

ResidentEvilWiki es una aplicación web desarrollada en Ruby on Rails que utiliza Bulma como framework CSS. El proyecto está orientado a la comunidad fan de Resident Evil, permitiendo la creación de blogs, reseñas, chats y más.

---

## Requisitos Previos

- **Ruby** 3.3.6
- **Rails** 7.1.5.1
- **Node.js** (recomendado instalar vía nvm o brew)
- **PostgreSQL**
- **Yarn** o **npm**

---

## Configuración Inicial

### 1. Variables de Entorno

Debes crear un archivo `.env` en la raíz del proyecto con las siguientes variables:

```env
GMAIL_USERNAME=tu_correo@gmail.com
GMAIL_PASSWORD=contraseña_de_aplicacion_google
```

- **GMAIL_USERNAME**: Correo de Gmail desde el cual se enviarán los emails.
- **GMAIL_PASSWORD**: Contraseña de aplicación generada desde la configuración de seguridad de Google (no tu contraseña personal).

### 2. Clave de Rails

Debes tener el archivo `config/master.key` con la clave secreta de Rails. Si no tienes este archivo, solicita la clave al equipo de desarrollo o genera una nueva con:

```bash
EDITOR="code --wait" bin/rails credentials:edit
```

Esto generará el archivo y la clave necesaria para desencriptar las credenciales.

---

## Instalación y Primer Arranque

Sigue este orden de comandos para instalar y preparar el entorno desde cero:

```bash
rm -rf storage/*
bundle install
npm install    
bin/rails db:drop db:create db:migrate db:seed
npm run build:css
bundle exec rails assets:precompile
bundle exec rails assets:clean
rails dev:cache
```

- Elimina archivos temporales y de almacenamiento.
- Instala gemas y dependencias de Node.
- Prepara la base de datos y carga los datos de ejemplo.
- Compila los estilos de Bulma.
- Precompila y limpia los assets de Rails.
- Activa el cache de desarrollo para evitar consumir la API en cada consulta.

---

## Arranque del servidor

En dos terminales distintas:

```bash
rails s
```

```bash
npm run watch:css
```

- El primer comando inicia el servidor Rails.
- El segundo mantiene la compilación de CSS en tiempo real.

---

## Flujo de trabajo para cambios en estilos

Cada vez que realices un cambio importante en un archivo `.scss`:

1. Detén ambos procesos (`rails s` y `npm run watch:css`).
2. Ejecuta:

    ```bash
    npm run build:css
    bundle exec rails assets:precompile
    bundle exec rails assets:clean
    ```

3. Vuelve a iniciar ambos procesos:

    ```bash
    rails s
    npm run watch:css
    ```

---

## Dependencias principales

- **Ruby on Rails**: Framework backend principal.
- **Bulma**: Framework CSS.
- **Sass**: Preprocesador CSS.
- **Devise**: Autenticación de usuarios.
- **Cloudinary**: Almacenamiento de imágenes.
- **dotenv-rails**: Manejo de variables de entorno.
- **Redis**: Soporte para Action Cable (WebSockets).
- **Importmap, Turbo, Stimulus**: SPA-like y JS moderno sin Webpack.

Consulta el `Gemfile` y `package.json` para más detalles.

---

## Documentación adicional

- `docs/diagrama-entidad-relacion.pdf`: Diagrama entidad-relación de la base de datos. Útil para entender la estructura y relaciones entre modelos.
- `docs/Paleta.pdf`: Paleta de colores oficial del proyecto para mantener la coherencia visual.
- Otros archivos en `docs/` pueden contener información relevante sobre la arquitectura, decisiones de diseño y manuales de usuario.

---

## Notas adicionales

- El sistema de autenticación requiere que el correo y la contraseña de aplicación sean válidos para el envío de emails (recuperación de contraseña, confirmaciones, etc).
- El archivo `master.key` es esencial para desencriptar las credenciales y variables sensibles de Rails.
- El almacenamiento de imágenes se realiza en Cloudinary, asegúrate de tener configuradas las credenciales necesarias en las variables de entorno o en las credenciales de Rails.

---

## Recursos útiles

- [Guía oficial de Rails](https://guides.rubyonrails.org/)
- [Documentación de Bulma](https://bulma.io/documentation/)
- [Documentación de Devise](https://github.com/heartcombo/devise)
- [Cloudinary para Rails](https://cloudinary.com/documentation/rails_integration)

---

Para cualquier duda adicional, revisa los archivos en la carpeta `docs/` o contacta al equipo de desarrollo.
