# backup_volumes
Este repositorio es encargado de respaldar y restaurar volúmenes de Docker del servidor.

## Respaldo local
Para hacer un respaldo local del volumen del `siap` solo debes de correr la instrucción:
`./src/back_up_my_volume`. Para que esta función pueda correr sin problemas, es necesario que
anteriormente hayas configurado una *ssh key* para poder acceder al servidor.

Con la instrucción `docker volume ls` podemos tener una lista de los volúmenes que tenemos
guardados. Después de hacer un _back up_ deberías de tener un volumen con el nombre:
`siap_mysql_vol_<FECHA>` donde en lugar de `<FECHA>` estará la fecha de cuando hiciste el respaldo.

## Restaurar volumen en el servidor
Para restaurar un respaldo en el servidor de algún volumen local del `siap` solo debes de correr la
instrucción `./src/restore_my_volume <FECHA>` donde en lugar de `<FECHA>`, estará la fecha de cuando
hiciste el respaldo con formato `yyyy-mm-dd`.

## Verificación del respaldo
Para comprobar que el respaldo está en el servidor debes hacer los siguientes pasos:
1. Entrar al servidor con la instrucción: `ssh ciencia_datos@islasgeci.org`
1. Enlistar los volúmenes de Docker con: `docker volume ls`. El volumen debería de aparecer como
   `siap_mysql_vol`.
1. Para ver la fecha de creación del volumen utilizamos la instrucción `docker volume inspect siap_mysql_vol`

Para verificar que el respaldo es el correcto debes seguir los siguientes pasos:
1. Echar a andar el contenedor con el volumen restaurado:

   `$docker run --detach --env="MYSQL_ROOT_PASSWORD=<CONTRASEÑA>" --name=<NOMBRE DEL CONTENEDOR>
   --publish 3306:3306 --volume=<NOMBRE DEL VOLUMEN>:/var/lib/mysql mysql`

   Donde el `<NOMBRE DEL CONTENEDOR>`, en este caso es `siap_mysql` y el `<NOMBRE DEL VOLUMEN>` es
   `siap_mysql_vol`.
1. Conectarnos a la base de datos mediante _DBeaver_ que estará expuesta en el puerto `3306`. La
   base de datos deberá tener los todos los cambios realizados hasta la fecha del respaldo.
