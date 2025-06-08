# 2025-1-grupo-56

## Link de deploy

<https://mysite-vqbg.onrender.com>

## Usuario Moderador

- nombre: `Moderador`
- email: `moderador@uc.cl`
- password: `123456`

### Para el desarrollo con Bulma

terminal 1:

```bash
npm install                                # instala Bulma y Sass desde package.json
npm run build:css                          # compila application.css primero
npm run watch:css                          # regenerará application.css al vuelo
```

terminal 2:

```bash
rails s
```

Esto es necesario para que los cambios en el CSS se vean reflejados al instante. Si no se hace, hay que esperar a que el servidor de Rails lo compile, lo cual puede tardar un poco.

Finalmente, reiniciar la base de datos local, para evitar errores de imagenes el local storage y utilizar el mismo esquema de la base de datos del deploy:

```bash
bin/rails db:drop db:create db:migrate db:seed
```

y borrar todo dentro de `storage`:

```bash
rm -rf storage/*
```

### En desarrollo local

Por cada cambio importante en aplication.bulma.scss, es necesario correr:

```bash
npm run build:css
bundle exec rails assets:clobber
bundle exec rails assets:precompile
bundle exec rails assets:clean
```

Esto es necesario para que los cambios se vean reflejados en el local storage y en el servidor de Rails.

#### API

Para no consumir en cada consulta la API, ejecuta el siguiente comando:

```bash
rails dev:cache
```

Esto hará que la API se cachee y no se consuma en cada consulta, lo cual es útil para el desarrollo local.
