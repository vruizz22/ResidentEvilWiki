#!/usr/bin/env bash
# Exit on error
set -o errexit

# Instala gems
bundle install

# Instala paquetes de Node
yarn install                                   # <-- Instala Bulma, Sass, etc. desde package.json

# Construye la hoja de estilos (bulma → app/assets/builds/application.css)
yarn build:css                                 # <-- Toma tu application.scss e inyecta Bulma :contentReference[oaicite:0]{index=0}

# Limpia assets viejos antes de precompilar
bundle exec rails assets:clobber

# Precompila los assets de Rails (incluye el CSS generado)
bundle exec rails assets:precompile             # <-- Ahora Rails encuentra application.css en app/assets/builds :contentReference[oaicite:1]{index=1}

# IMPORTANTE: Genera el importmap para producción
bin/importmap json

# Limpia archivos viejos
bundle exec rails assets:clean

# Limpia el caché de Rails
bundle exec rails runner "Rails.cache.clear"

# Migra la base de datos (si usas Free tier)
bundle exec rails db:migrate
bundle exec rails db:seed
