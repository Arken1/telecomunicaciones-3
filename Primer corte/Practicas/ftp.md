# FTP (File Transfer Protocol)

Es un protocolo de red para la transferencia de archivos entre sistemas conectados a una red TCP (Transmission Control Protocol), basado en la arquitectura cliente-servidor.

| Servicio     | Puerto |
| ------------ | ------ |
| FTP (activo) | `20`   |
| FTP (pasivo) | `21`   |

## Contenido

- [FTP (File Transfer Protocol)](#ftp-file-transfer-protocol)
  - [Contenido](#contenido)
  - [Servidor VSFTPD (Very Secure FTP Daemon)](#servidor-vsftpd-very-secure-ftp-daemon)
    - [Comandos del servicios](#comandos-del-servicios)
    - [Archivo de configuración](#archivo-de-configuración)
    - [Usuarios](#usuarios)
      - [Crear usuario](#crear-usuario)
      - [Crear contraseña](#crear-contraseña)
      - [Borrar usuario](#borrar-usuario)
      - [Modificar usuario](#modificar-usuario)
      - [Lista de usuarios](#lista-de-usuarios)
      - [Archivo de usuarios root](#archivo-de-usuarios-root)
      - [Archivo de usuarios bloqueados](#archivo-de-usuarios-bloqueados)
      - [Set the root directory for files available via FTP](#set-the-root-directory-for-files-available-via-ftp)
    - [Consultas desde el Cliente](#consultas-desde-el-cliente)
  - [Usuarios creados](#usuarios-creados)
  - [Referencias](#referencias)

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

Guia de comandos

| Command              | Description                                                                                                                                                                  |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bye / close / quit | Terminates an FTP connection.                                                                                                                                                |
| cd                   | Changes the current working directory on the FTP host server.                                                                                                                |
| cwd                  | Changes the current directory to the specified remote directory.                                                                                                             |
| dir                  | Requests a directory of files uploaded or available for download.                                                                                                            |
| get                  | Downloads a single file.                                                                                                                                                     |
| ls                   | Requests a list of file names uploaded or available for download.                                                                                                            |
| mget                 | Interactively downloads multiple files.                                                                                                                                      |
| mput                 | Interactively uploads multiple files.                                                                                                                                        |
| open                 | Starts an FTP connection.                                                                                                                                                    |
| pasv                 | Tells the server to enter passive mode, in which the server waits for the client to establish a connection rather than attempting to connect to a port the client specifies. |
| put                  | Uploads a single file.                                                                                                                                                       |
| pwd                  | Queries the current working directory.                                                                                                                                       |
| ren                  | Renames or moves a file.                                                                                                                                                     |
| site                 | Executes a site-specific command.                                                                                                                                            |
| type                 | Sets the file transfer mode: ASCII,Binary                                                                                                                                    |

Tomado de [^2]

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
> Puede visitar el repositorio de invitado, por el usuario `guest` y password `guest`
> Puede visitar el repositorio publico, por el usuario `anonymous`

## Referencias

[^1]: [Instalar servidor FTP y restringir permisos a los usuarios](https://rootear.com/ubuntu-linux/instalar-servidor-ftp)
[^2]: [Summary of FTP Client Commands](https://www.ibm.com/docs/en/scbn?topic=SSRJDU/gateway_services/ftp_globalec/SCN_Summary_of_FTP_Client_Commands_b.html)
