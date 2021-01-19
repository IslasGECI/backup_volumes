# backup_volumes
Este repositorio es encargado de respaldar y restaurar volúmenes del servidor.

## Respaldo local
Para hacer un respaldo local del volumen del `siap` solo debes de correr la instrucción: 
`./src/back_up_my_volume`. Para que esta función pueda correr sin problemas, es necesario que
anteriormente hayas configurado una *ssh key* para poder acceder al servidor.

Con la instrucción `docker volume ls` podemos tener una lista de los volúmenes que tenemos
guardados. Después de hacer un _back up_ deberías de tener un vólumen con el nombre:
`siap_mysql_vol_fecha` donde en lugar de `fecha` estará la fecha de cuando hiciste el respaldo. 

## Respaldo en el servidor
Para hacer un respaldo en el servidor de algún volumen local del `siap` solo deber de correr la
instrucción `./src/restore_my_volume 2021-01-19`.

Para comprobar que el respaldo está en el servidor debes hacer los siguientes pasos:
1. Entrar al servidor con la instrucción: `ssh ciencia_datos@islasgeci.org`
1. Enlistar los voúmenes de Docker con: `docker volume ls`. El volumen debería de aparecer como `siap_mysql_vol`.
1. Echar a andar el contenedor con el volumen restaurado:

   `$docker run --detach --env=”MYSQL_ROOT_PASSWORD=<CONTRASEÑA>” --name=<NOMBRE DEL CONTENEDOR> --publish 3306:3306 --volume=<NOMBRE DEL VOLUMEN>:/var/lib/mysql mysql`

    Dónde el nombre del contenedor, en este caso es `siap_mysql` y el nombre del volumen es `siap_mysql_vol`.
