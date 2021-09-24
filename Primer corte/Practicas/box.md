# Vagrant Box

## Publicar un box en Vagrant Cloud

### Empaquetamos nuestro box

```apache
vagrant package <<servidor>> --out my<<Servidor>>.box
```

### Agregamos Box a la instalacion Vagrant

```apache
vagrant box add vm_my<<Servidor>> myServidor.box
```

### Verificamos que el box exista

```apache
ls
vagrant box list
```

Subir a [Vagrant Cloud](https://app.vagrantup.com/)

## Crear una copia

Antes de iniciar, verificamos que las copias de seguridad este activas en "released"

### Generamos un VagrantFile

```apache
vagrant init
```

### Modificamos el archivo

En el VagrantFile, especificando la dirección de la copia de seguridad, la dirección ip y el sistema operativo

```ruby
Vagrant.configure("2") do |config|
  config.vm.define :<<nueva_maquina>> do |<<nueva_maquina>>|
    <<nueva_maquina>>.vm.box = "<<bento/centos-7.9>>"
    <<nueva_maquina>>.vm.box = "<<usuario>>/<<vm_box>>"
    <<nueva_maquina>>.vm.box_version = "x.x.x"
    <<nueva_maquina>>.vm.network :private_network, ip: "255.255.255.255"
    <<nueva_maquina>>.vm.hostname = "<<nueva_maquina>>"
  end
  ...
end
```

vagrant init miguel-rondon/vm_server \ --box-version 0.0.3
