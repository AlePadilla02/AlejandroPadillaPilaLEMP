# AlejandroPadillaPilaLEMP

# Índice
1. [Introducción](#introducción)
2. [Configuración del balanceador web](#configuración-del-balanceador-web)
3. [Configuración de la PilaLEMP](#configuración-de-la-pilalemp)
   - [Configuración de los servidores web](#configuración-de-los-servidores-web)
   - [Configuración del servidor NFS y motor PHP-FPM](#configuración-del-servidor-nfs-y-motor-php-fpm)
4. [Configuración del servidor de datos](#configuración-del-servidor-de-datos)
5. [Instalación WordPress](#instalación-wordpress)
6. [Conclusión](#conclusión)
7. [Vídeo](#vídeo)

## Introducción:
#### En esta práctica realizaremos el lanzamiento de una página de WordPress con una PilaLEMP a 3 capas , donde en la primera capa tendremos un balanceador nginx con la IP 192.168.3.5 en el backend, tendremos 2 servidores web con nginx con las IPs 192.168.3.6/192.168.2.6 y 192.168.3.7/192.168.2.8 además de un servidor NFS con motor php-fpm con las IPs 192.168.2.9/192.168.4.6 y por último un servidor de base de datos con mariadb con las IPs 192.168.2.10/192.168.4.5. A continucación, se va a realizar la configuración necesaria para poder desplegar nuestra aplicación comenzando por el balanceador web. 
#### (Aclaración: Todas las máquinas del backend no tienen Internet, solo tiene Internet el balanceador web, ya que en el Vagrantfile tiene una tarjeta de red que le permite el acceso a Internet).
## Configuración del balanceador web
#### Previamente, se ha lanzado el fichero de aprovisionamiento donde se han actualizado los repositorios e instalado el paquete nginx. Ahora, tocaría deshabilitar el fichero default del sites-available de nginx:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/47672146-3f36-48ee-bb77-ff60158cb8ff)

#### Una vez realizado lo anterior, quedaría crear el fichero de configuración para hacer de balanceador entre los servidores web, poniendo sus respectivas IPs:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/6a867a32-4750-4643-9d18-1bf0361ad5e9)

## Configuración de la PilaLEMP

### Configuración de los servidores web
#### Previamente, se ha lanzado el fichero de aprovisionamiento donde se han actualizado los repositorios, instalado el paquete nginx y el paquete el cliente de NFS. Ahora, editaremos el fichero default del sites-available de nginx en cada servidor web, donde lo que se ha modificado es la ruta donde va a consultar el DocumentRoot para nuestra página de WordPress, añadir en el apartado de índices index.php y por último añadir el fastcgi del servidor NFS para que se puedan comunicar a la hora de montar a las carpetas compartidas.
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/7c9bcf9a-f196-45c0-b00c-9f803e98a862)

![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/32886ec9-9533-439d-80d6-fae578a285e3)

#### Hay que crear las carpetas compartidas en ambos servidores web y montarlas para el funcionamiento del servidor NFS:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/86232d74-a80e-4190-adfd-382db47ce893)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/a3b4a86e-0fd0-477c-9998-d8856b47602d)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/760533c7-4d6a-4692-9638-9945998d6349)

#### A continuación, desde el balanceador web, se realizará la descarga del el fichero tar que contiene WordPress y lo pasaremos vía scp a todo el backend. Habrá que descomprimirlo en el directorio /var/www/html, asignarle los permisos necesarios para el uso de la aplicación e instalación además de cambiar el propietario por www-data:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/2ad55e80-7e88-4fcc-8705-42576afeb399)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/affb4632-5b4a-4e92-8a27-417486b98859)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/d52af2d7-3d6e-4450-b798-734f6be843f7)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/9a91e252-a264-4366-8a3e-198a02ae09ab)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/aadbbbd0-decf-4de9-935a-4dcf7f5ea63e)

#### Después de realizar todo lo anterior, el siguiente paso es cambiar de nombre el fichero wp-config-sample.php a wp-config.php y modificar dicho fichero en ambos servidores web, con los datos de nuestra base de datos que posteriormente se creará:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/59f9183c-2872-4232-89ae-f1485e74d7bc)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/3b9877c7-8b23-4cc3-aa27-9e498beb4560)

### Configuración del servidor NFS y motor PHP-FPM
#### Previamente, se ha lanzado el fichero de aprovisionamiento donde se han actualizado los repositorios e instalado los paquetes nfs-kernel-server, php-fpm y php-mysql. A continuación, se editará el fichero de configuración de php para que escuche por la IP correspondiente asociado a un puerto que anteriormente hemos configurado en nuestros ficheros default de los servidores web:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/c6dc1705-d971-452e-98bb-98adee48edd9)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/0360c619-a34c-48d3-a5ad-2cbaf2f4b08c)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/3ca9a6f8-17bb-4deb-b61f-622486add777)

#### Lo siguiente sería crear la carpeta compartida del servidor NFS y cambiarles el propietario y el grupo a ninguno:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/b3bcd1c6-3719-4079-987e-729fec193978)

#### Una vez realizado el paso anterior, hay que editar el fichero exports en /etc y añadiremos las rutas, IP de cada servidor web y los permisos que se le van a asignar dentro de dichas carpetas:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/ecf8f002-ed45-4969-8e11-20d992a92fac)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/c41b8bc6-5170-48f7-ad9d-d5b3e81af012)

#### Finalmente, crearemos la ruta /var/www/html y moveremos el fichero tar pasado anteriormente con scp desde el balanceador web y se descomprimirá en dicho directorio:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/bfc781b1-1665-4279-9655-bba93412b81d)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/b7af1e8c-5f9e-40a3-9088-86e6970fe012)

## Configuración del servidor de datos
#### Previamente, se ha lanzado el fichero de aprovisionamiento donde se han actualizado los repositorios e instalado el paquete mariadb-server. Ahora, hay que crear la base de datos junto al usuario con el que se conectarán los servidores web, otorgándole al usuario los permisos necesarios:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/ab034fa0-f976-45dd-b99a-bd86c4efe0c4)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/1c753549-cb1b-4b4b-9c6e-17c948e6f9e1)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/2dcbdf76-273c-4458-89b1-43e46a0f3b91)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/f88a4f1e-cb0a-4532-b951-dc923773343d)

#### Además, hay que modificar el fichero 50-server.conf de mariadb y cmabiarle el bind-addresss por la IP de su tarjeta de red donde se comunica con los servidores web para el acceso a la base de datos:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/5f305e90-1f79-43e5-b62a-f90b5cbdb6bc)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/2481eb20-f3b5-4578-acc2-1c0179349cae)

## Instalación WordPress:
#### Hay que acceder desde la máquina anfitriona al WordPress para su instalación poniendo en la barra de búsqueda del navegador localhost y el puerto mapeado:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/e4b33c3b-2d6f-4769-9264-27532a9d52cd)
#### (No pude realizar la captura correcta de la instalación pero esto es lo que saldría)

#### Y por último, crear el usuario administrador y acceder al WordPress para personalizarlo:
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/c6090c19-74d6-420b-9b42-b87cd78fa1c9)
![image](https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/68295e3d-7d91-460c-91e1-ef76dda2d876)


## Conclusión
#### En conclusión, disponemos de una infraestructura robusta con capacidad de escalado y con una alta disponibilidad. Aunque, si quisieramos perfeccionar esta infraestructura, quedaría realizar otro balanceador de carga más un servidor de datos y realizar un haproxy de un clúster galera. Con esto concluye esta práctica.

## Vídeo
#### A continuación tenemos el vídeo de comprobación de nuestra aplicación web desplegada en una PilaLEMP a 3 niveles:
https://github.com/AlePadilla02/AlejandroPadillaPilaLEMP/assets/146703765/2b495a6b-885c-447b-84a3-a0a5912e8bec
