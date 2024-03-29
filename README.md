<img src="https://www.islas.org.mx/img/logo.svg" align="right" width="256" />

# backup_volumes

Este repositorio es encargado de respaldar y restaurar volúmenes de Docker del servidor.

## Respaldo local de un volumen que se encuentra en un servidor
Para hacer un respaldo local de un volumen que se encuentra en un servidor, solo debes de correr la
instrucción: `./src/back_up_my_volume <NOMBRE_DEL_VOLUMEN> <USUARIO@SERVIDOR>`. Para que esta
función pueda correr sin problemas, es necesario que anteriormente hayas configurado una *ssh key*
para que el `<USUARIO>` tenga acceso al `<SERVIDOR>`
Por ejemplo:
```shell
$ ./src/back_up_my_volume siap ciencia_datos@islasgeci.org
```

Con la instrucción `docker volume ls` podemos tener una lista de los volúmenes que tenemos
guardados. Después de hacer un _back up_ deberías de tener un volumen con el nombre:
`siap_mysql_vol_<FECHA>` donde en lugar de `<FECHA>` estará la fecha de cuando hiciste el respaldo.

## Restaurar volumen en el servidor
Para restaurar un volumen local en el `<SERVIDOR>` debes de correr la instrucción
`./src/restore_my_volume <NOMBRE_DEL_VOLUMEN> <FECHA> <USUARIO@SERVIDOR>` donde en lugar de
`<FECHA>`, estará la fecha de cuando hiciste el respaldo con formato `yyyy-mm-dd`.
Por ejemplo:
```shell
$ ./src/restore_my_volume siap 2021-07-05 ciencia_datos@islasgeci.org
```

## Verificación del respaldo
Para comprobar que el respaldo está en el servidor debes hacer los siguientes pasos:
1. Entrar al servidor con la instrucción: `ssh ciencia_datos@islasgeci.org`
1. Enlistar los volúmenes de Docker con: `docker volume ls`. El volumen debería de aparecer como
   `<NOMBRE_DEL_VOLUMEN>`.
1. Para ver la fecha de creación del volumen utilizamos la instrucción `docker volume inspect <NOMBRE_DEL_VOLUMEN>`

Para verificar que el respaldo es el correcto debes seguir los siguientes pasos:
1. Echar a andar el contenedor con el volumen restaurado:
```shell
$ docker run --detach --env="MYSQL_ROOT_PASSWORD=<CONTRASEÑA>" --name=<NOMBRE DEL CONTENEDOR> --publish 3306:3306 --volume=<NOMBRE_DEL_VOLUMEN>:/var/lib/mysql mysql
```

Por ejemplo:

```shell
$ docker run --detach --env="MYSQL_ROOT_PASSWORD=<CONTRASEÑA>" --name=siap_mysql --publish 3306:3306 --volume=siap:/var/lib/mysql mysql
```

1. Conectarnos a la base de datos mediante _DBeaver_ que estará expuesta en el puerto `3306`. La
   base de datos deberá tener los todos los cambios realizados hasta la fecha del respaldo.
