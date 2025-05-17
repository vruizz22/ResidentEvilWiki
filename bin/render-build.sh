#!/usr/bin/env bash
# Exit on error
set -o errexit

# Instala gems
bundle install

# Instala paquetes de Node
yarn install                                   # <-- Instala Bulma, Sass, etc. desde package.json

# Construye la hoja de estilos (bulma → app/assets/builds/application.css)
yarn build:css                                 # <-- Toma tu application.scss e inyecta Bulma :contentReference[oaicite:0]{index=0}

# Precompila los assets de Rails (incluye el CSS generado)
bundle exec rails assets:precompile             # <-- Ahora Rails encuentra application.css en app/assets/builds :contentReference[oaicite:1]{index=1}

# Limpia archivos viejos
bundle exec rails assets:clean

# Migra la base de datos (si usas Free tier)
bundle exec rails db:migrate
