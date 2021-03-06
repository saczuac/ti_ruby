# Trabajo Final

Este proyecto es el trabajo final para la materia TTPS Ruby de la facultad de informática de la UNLP

## Dependencias 

Para poder correr este proyecto necesitará de las siguientes **dependencias**:

* Ruby version: >= 2.3.1

* Database: postgresql

* Gema *bundler*

* Gema *rails*

## Configuración

Para poder inicializar el proyecto correr los siguientes *comandos* en una consola linux parado adentro del directorio del proyecto:

+ Para instalar las gemas del proyecto: ```bundle install```

+ Para crear la base de datos: ```bundle exec rails db:create```

+ Para correr las migraciones de la base de datos: ```bundle exec rails db:migrate```

+ Para generar los seeds de datos iniciales de la base de datos: ```bundle exec rails db:seed```

## Correr tests

Se utilizó *rspec* para la elaboración de tests, para correr dichos tests utiizar el comando ```bundle exec rspec``` 

## Inicialización

Para inicializar el servidor simplemente correr el comando ```bundle exec rails server``` y dirigirse a un navegador a localhost:3000 

## Deploy en Heroku

En caso de no querer instalar localmente el proyecto puede utilizarse el despliege en heroku: [link a la aplicación](https://todoruby.herokuapp.com/) 

Recordar que se encuentra una lista llamada "Lista 0" cuyas tareas se dieron de alta en los seeds. Para poder acceder a ella simplemente hágalo por su slug: *lista-0*