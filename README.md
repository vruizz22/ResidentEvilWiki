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
