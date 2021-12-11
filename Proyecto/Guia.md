# Guia de trabajo

Para la implementacion del servicio NAGIOS se tiene como referente la documentacion de la pagina oficial asociada al monitoreo con NAGIOS XI [^1]

## Paso 1

Ingreso a página principal Nagios

![Interfaz de usuario gráfica, Sitio web Descripción generada automáticamente](<./Fotos/F%20(1).png>)

## Paso 2

Selección botón “Download Free Trial”

![Calendario Descripción generada automáticamente con confianza media](<./Fotos/F%20(2).png>)

## Paso 3

Como estamos trabajando sobre Windows, seleccionamos la opción “Microsoft”

![Foto](<./Fotos/F%20(3).png>)

## Paso 4

Seleccionamos descargar Nagios XI en un formato .ova (Open Virtualization Format) por ser compatible con VirtualBox que ha sido el ambiente de virtualización usado durante el transcurso de la asignatura [^2]

![Foto](<./Fotos/F%20(4).png>)

## Paso 5

Abro el archivo .ova, el cual de forma automática se conecta con VirtualBox (mi ambiente de virtualización), y solicita datos para la creación de una máquina virtual.

![Foto](<./Fotos/F%20(5).png>)

## Paso 6

Para identificar la máquina se le asigna el nombre “Monitor” mientras que el resto de las configuraciones se dejan por default (es importante tener en cuenta que esta máquina está conectada al adaptador de red, es decir pertenece a la red del host, lo que en vagrant sería una “public_network”)

![Foto](<./Fotos/F%20(6).png>)

## Paso 7

Se selecciona el botón de “importar” y empieza el proceso de importar la maquina descargada de Nagios XI

![Foto](<./Fotos/F%20(7).png>)

## Paso 8

Iniciar la máquina importada

![Foto](<./Fotos/F%20(8).png>)

## Paso 9

Inicio Automático de la máquina

![Foto](<./Fotos/F%20(9).png>)

![Foto](<./Fotos/F%20(10).png>)

## Paso 10

Para acceder a la máquina Nagios indica que se debe usar el usuario “root” y la contraseña (por default) “nagiosxi”, y para acceder a la interfaz de monitoreo se debe ingresar en el browser la dirección <http://192.168.1.11> , es decir, usar la ip “pública” de la máquina.

![Foto](<./Fotos/F%20(11).png>)

## Paso 11

Seleccionar “Access Nagios XI” y llenar el formulario de registro para la instalación del monitor

![Foto](<./Fotos/F%20(12).png>)

## Paso 12

Llenar el formulario de acceso del administrador

![Foto](<./Fotos/F%20(13).png>)

![Foto](<./Fotos/F%20(14).png>)

![Foto](<./Fotos/F%20(15).png>)

## Paso 13

Ingresar a la interfaz de monitoreo

![Foto](<./Fotos/F%20(16).png>)

![Foto](<./Fotos/F%20(43).png>)

## Paso 14

Ingreso a la interfaz “básica”

![Foto](<./Fotos/F%20(17).png>)

Por defecto se puede ver que un “host” (dispositivo de red) está siendo monitoreado y dentro de él 12 servicios. Este dispositivo en realidad es la máquina que se instala por defecto en el anfitrión, es decir, la máquina “Monitor”.

## Paso 15

Para agregar dispositivos a la red y posteriormente monitorearlos, se crearon 2 máquinas Vagrant a partir de los boxes del servidor usado durante las prácticas del curso, por tanto, tienen los servicios FTP, HTTP, y SMTP:

![Foto](<./Fotos/F%20(18).png>)

## Paso 16

Para iniciar a monitorearlas hay diferentes opciones:

![Foto](<./Fotos/F%20(19).png>)

## Paso 17

Si se selecciona la primera opción, se muestran las diferentes configuraciones para el monitoreo y de este modo se puede agregar manualmente uno a uno cada parámetro que se desea monitorear entre los disponibles. Ejemplo: ftp

![Foto](<./Fotos/F%20(20).png>)

![Foto](<./Fotos/F%20(21).png>)

![Foto](<./Fotos/F%20(22).png>)

![Foto](<./Fotos/F%20(23).png>)

![Foto](<./Fotos/F%20(24).png>)

Ya en este punto puedo finalizar la configuración

## Paso 18

Verificar el funcionamiento y revisar que se haya agregado un nuevo host (Esto se puede ver en la página de inicio)

![Foto](<./Fotos/F%20(25).png>)

![Foto](<./Fotos/F%20(26).png>)

## Paso 19

La segunda opción para configurar el monitoreo (“tareas de autodescubrimiento”)

![Foto](<./Fotos/F%20(27).png>)

![Foto](<./Fotos/F%20(28).png>)

![Foto](<./Fotos/F%20(29).png>)

![Foto](<./Fotos/F%20(30).png>)

## Paso 20

Ejecutar asistente y seleccionar los hosts a monitorear

![Foto](<./Fotos/F%20(31).png>)

![Foto](<./Fotos/F%20(32).png>)

![Foto](<./Fotos/F%20(33).png>)

![Foto](<./Fotos/F%20(34).png>)

![Foto](<./Fotos/F%20(35).png>)

![Foto](<./Fotos/F%20(36).png>)

## Paso 21

Hasta este punto solo estamos monitoreando servicios y no el estado de las máquinas, para esto en las tareas de autodescubrimiento se selecciona “ver los resultados del trabajo”

![Foto](<./Fotos/F%20(37).png>)

![Foto](<./Fotos/F%20(38).png>)

![Foto](<./Fotos/F%20(39).png>)

![Foto](<./Fotos/F%20(40).png>)

## Paso 22

Seleccionar “ejecute el asistente”

![Foto](<./Fotos/F%20(41).png>)

![Foto](<./Fotos/F%20(42).png>)

## Referencias

[^1]: [Documentación](https://www.nagios.com/resources/nagios-xi/)
[^2]: [Nagio XI](https://www.nagios.com/products/nagios-xi/)
