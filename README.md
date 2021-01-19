# backup_volumes
Este repositorio es encargado de respaldar y restaurar volúmenes del servidor.

## Respaldo local
Para hacer un respaldo local del volumen del `siap` solo debes de correr la instrucción: 
`./src/back_up_my_volume`.

Con la instrucción `docker volume ls` podemos tener una lista de los volúmenes que tenemos
guardados. Después de hacer un _back up_ deberías de tener un vólumen con el nombre:
`siap_mysql_vol_fecha` donde en lugar de `fecha` estará la fecha de cuando hiciste el respaldo. 

## Respaldo en el servidor
Para hacer un respaldo en el servidor de algún volumen local del `siap` solo deber de correr la
instrucción `./src/restore_my_volume 2021-01-19`.

Para comprobar que el respaldo está en el servidor debes hacer los siguientes pasos:
1. Paso 1
1. Paso 2
1. Paso 3