# FTP (File Transfer Protocol)

Es un protocolo de red para la transferencia de archivos entre sistemas conectados a una red TCP (Transmission Control Protocol), basado en la arquitectura cliente-servidor.

| Servicio     | Puerto |
| ------------ | ------ |
| FTP (activo) | `20`   |
| FTP (pasivo) | `21`   |

## Servidor VSFTPD (Very Secure FTP Daemon)

!comando

### Comandos del servicios

```apache
service vsftpd start
service vsftpd stop
service vsftpd restart
service vsftpd condrestart
```

### Archivo de configuración

```apache
/etc/vsftpd/vsftpd.conf
```

### Usuarios

Ver [^1]

#### Crear usuario

```apache
mkdir /home/ftp/usuarioftp
chmod 777 /home/ftp/usuarioftp

useradd -g ftp -s /bin/ftp -d /home/ftp/usuarioftp -c "Nombre del Usuario" usuarioftp
```

#### Crear contraseña

```apache
passwd usuarioftp
```

#### Borrar usuario

```kotlin
usermod [options] LOGIN
```

#### Modificar usuario

```apache
userdel -r nombre del usuario
```

#### Lista de usuarios

```apache
cat /etc/passwd
cat /etc/passwd | wc -l
```

#### Archivo de usuarios root

```apache
/etc/vsftpd/chroot_list
```

#### Archivo de usuarios bloqueados

```apache
/etc/vsftpd.denied_users
```

#### Set the root directory for files available via FTP

```apache
tftp-root=/var/ftpd
```

### Consultas desde el Cliente

```apache
ftp 192.168.50.3
mslookup
```

## Usuarios creados

| username     | access      | note              | directory                       |
| ------------ | ----------- | ----------------- | ------------------------------- | --------- |
| usuarioftp   | x:1004:118  | Usuario           | /home/ftp/usuarioftp            | /bin/bash |
| guest        | x:1005:50   | Invitado 1        | /home/ftp/guest:/bin/ftp        |
| denied_users | x:1006:50   | Usuario Bloqueado | /home/ftp/denied_users:/bin/ftp |
| users2       | x:1007:50   | Usuario2          | /home/ftp/user2:/bin/bash       |
| user3        | x:1008:1008 | Usuario 3         | /home/user3:/bin/bash           |
| pedrope      | x:1009:1009 | Pedro Perez       | /home/httpd/pedrope:/bin/httpd  |
| mariamar     | x:1010:1009 | Maria Martínez    | /home/httpd/mariamar:/bin/httpd |
| juangon      | x:1011:1009 | Juan Gonzáles     | /home/httpd/juangon:/bin/httpd  |

> [!NOTE]
> Contraseña por defecto para todos los usuarios `1234`

## Referencias

[^1]: [Instalar servidor FTP y restringir permisos a los usuarios](https://rootear.com/ubuntu-linux/instalar-servidor-ftp)
