🖖 INFORME TÉCNICO DE MISIÓN FINAL

📝 Datos de la Misión

**Misión:** Reactivación del Núcleo Web en Base Lunar Alfa
**Cadete:** [Marcos Valero Báscones]
**ID de Grupo:** [56]
**Usuario GitHub:** `darksz12`

Misión 1: Registro de Entrada (Personalización MOTD)
Implementé un *script* de Bash que se ejecuta al inicio de sesión para generar un mensaje de bienvenida dinámico (MOTD), mostrando mis datos como cadete y mi ficha estelar.

Procedimiento: Creación y asignación de permisos de ejecución al script en `/etc/update-motd.d/`.
Comandos Clave:
Asignación de permisos de ejecución para la activación dinámica del script:
sudo chmod +x /etc/update-motd.d/99-flota
 La fecha estelar la generé mediante el comando de sustitución: $(date +"%Y.%m%d.%H%M")

Misión 2: Instalación del Núcleo de Servicios (Pila LAMP)

Procedí a la instalación del entorno LAMP (Apache, MariaDB y PHP).Confirme la correcta integración del módulo **`libapache2-mod-php`** para el procesamiento del código dinámico.
Procedimiento: Instalación en un único comando para minimizar la sobrecarga del sistema, seguida por la configuración de seguridad.
Comandos Clave:
Instalación de los componentes principales (Apache, MariaDB, PHP y módulos):
sudo apt install -y apache2 mariadb-server php libapache2-mod-php php-mysql
Refuerzo de seguridad crítico de la base de datos (eliminación de usuarios anónimos, etc.):
sudo mysql_secure_installation
Verificación funcional de PHP (abrir en navegador: http://[IP]/info.php):
echo '<?php phpinfo(); ?>' | sudo tee /var/www/html/info.php

Misión 3: Activación del Escudo Deflector (Firewall UFW)
Se levantaron los escudos defensores siguiendo el protocolo de acceso mínimo (`deny incoming` por defecto) para garantizar la seguridad perimetral.
Procedimiento:Abrí explícitamente solo los puertos de comunicación esenciales para la administración y el servicio web.

Comandos Clave:
Reglas de permiso explícito para los canales esenciales:
sudo ufw allow ssh 
sudo ufw allow http
sudo ufw allow https

Activación del firewall:
sudo ufw enable

Comando de verificación para la auditoría de reglas:
sudo ufw status numbered

Misión 4: Registro de Telemetría (JSON + Panel LCARS)
Implementé un sistema de monitorización basado en la recolección de datos del sistema y la visualización en una interfaz web dinámica.
Procedimiento:El script telemetria.sh utiliza herramientas de sistema (`systemctl`, `uptime`) junto con jq para generar un archivo JSON válido. Este archivo es leído por el JavaScript dentro del index.html (Panel LCARS) mediante la función fetch, permitiendo la visualización de estados en tiempo real.
Comandos Clave:

Instalación de la herramienta JSON:
sudo apt install -y jq

Comando de ejecución del script (genera el archivo telemetria.json)
sudo /usr/local/bin/telemetria.sh

Misión 5: Registro Estelar (Git y GitHub)
Trabajo preparado y resgistrado para el Repositorio estelar mio como cadete (`darksz12`), cumpliendo con el protocolo de control de versiones.
Procedimiento: Se inicializó Git, se recolectaron los artefactos generados y se preparó la subida final a GitHub.
Comandos Clave (Flujo Final):
Inicialización y vinculación del repositorio local con GitHub:
git init
git remote add origin https://github.com/darksz12/starfleet-prueba-competencial-MARCOS.git


🐋 Informe Técnico: Activación del Módulo de Simulación - DockerMisión: Despliegue de Aplicación Web Multicontenedor y Certificación de Módulo de Ingeniería.Cadete: Marcos Valero BásconesID de Grupo: 56Usuario GitHub: darksz121. RESUMEN EJECUTIVO Y OBJETIVOSEsta misión requirió el dominio de la orquestación de contenedores para desplegar un sistema de registro de misión (WordPress + MariaDB) y la posterior certificación de un Módulo de Ingeniería personalizado. Se demostró el manejo de redes internas, volúmenes y el flujo de Dockerfile.ObjetivoEstadoConcepto DemostradoDespliegue WordPressCOMPLETADOConectividad y persistencia en despliegue manual.Imagen PersonalizadaCOMPLETADODockerfile, docker build, docker push a Docker Hub.Análisis de SeguridadCOMPLETADOAuditoría de código desconocido (mision_oculta.sh).2. PROCEDIMIENTOS CLAVE EJECUTADOSSe detalla la secuencia de comandos utilizada para el despliegue manual de contenedores y la certificación del módulo.A. Preparación y Despliegue de WordPressLa aplicación WordPress se desplegó en dos contenedores interconectados mediante una red privada interna y volúmenes persistentes.Procedimiento: Creación de la red interna y lanzamiento de MariaDB, seguido por el contenedor de WordPress (expuesto en el puerto 8080).Bash# Creación de la red interna para la comunicación DB-Web
docker network create wordpress-net

# Creación de volúmenes persistentes
docker volume create db-data
docker volume create wp-data

# Lanzamiento de la Base de Datos (MariaDB)
docker run -d --name wordpress_db --network wordpress-net -e MYSQL_ROOT_PASSWORD=SECRETO1 \
    -e MYSQL_DATABASE=wp_db -e MYSQL_USER=wp_user -e MYSQL_PASSWORD=SECRETO1 -v db-data:/var/lib/mysql mariadb:10.6

# Lanzamiento de la Aplicación Web (WordPress), expuesta en el puerto 8080
docker run -d --name wordpress_app --network wordpress-net -p 8080:80 \
    -e WORDPRESS_DB_HOST=wordpress_db \
    -e WORDPRESS_DB_USER=wp_user -e WORDPRESS_DB_PASSWORD=SECRETO1 \
    -e WORDPRESS_DB_NAME=wp_db -v wp-data:/var/www/html wordpress:latest
B. Certificación del Módulo de Ingeniería (Imagen Personalizada)Se construyó un módulo web personalizado (darksens05/modulo-ingenieria:2.0), con un panel LCARS de aprobación.Procedimiento: Creación del index.html con estilo Starfleet, definición de la receta en el Dockerfile y subida al registro.Bash# Creación del directorio de contexto (mi-modulo) y el archivo web
mkdir mi-modulo && cd mi-modulo
echo '<h1>MÓDULO DE INGENIERÍA: APROBADO | darksz12 V2.0</h1>' > index.html

# Definición del Dockerfile:
# FROM httpd:alpine
# COPY index.html /usr/local/apache2/htdocs/
# EXPOSE 80

# Construcción de la imagen (etiquetada con el usuario correcto)
docker build -t darksens05/modulo-ingenieria:2.0 .

# Subida final al registro de Docker Hub (usando el Token PAT)
docker push darksens05/modulo-ingenieria:2.0
C. Análisis de Seguridad (mision_oculta.sh)Se cumplió con el protocolo de seguridad de la Flota Estelar al analizar el contenido de un script desconocido (mision_oculta.sh) en lugar de ejecutarlo directamente, demostrando la precaución de un administrador ante código no verificado.Comando Clave de Auditoría:Bashcat mision_oculta.sh
3. CONCLUSIÓN TÉCNICAEl despliegue de WordPress en el puerto 8080 y la certificación del módulo en el puerto 8081 demuestran la capacidad de manejar entornos de contenedores complejos. El uso de la red (--network) y de los volúmenes garantiza la persistencia y la estabilidad del sistema, mientras que la subida de la imagen final certifica la portabilidad del módulo aprobado




🔒 Informe Técnico: Misión Oculta - Auditoría Final de Sistemas
Misión: Análisis del Script Oculto mision_oculta.sh

Objetivo: Ejecutar un diagnóstico completo del sistema (SRI/SAD) para demostrar el dominio en la recolección de telemetría, el manejo de Docker y la lógica de scripting.

Cadete: Marcos Valero Báscones

1. ANÁLISIS Y DIAGNÓSTICO DEL SISTEMA
Se ejecutaron los comandos de la Misión Oculta para diagnosticar el estado del servidor y la infraestructura de contenedores (WordPress y MariaDB).

1.1 Servicios Críticos (Punto 1)
El diagnóstico verifica la operatividad de los servicios esenciales de la Pila LAMP y la seguridad perimetral.

Apache2: systemctl status apache2 | grep "Active" (Servidor Web)

MariaDB/MySQL: systemctl status mariadb | grep "Active" (Base de Datos)

UFW (Firewall): systemctl status ufw | grep "Active" (Seguridad Perimetral)

Comando para obtener Runlevel: systemctl get-default (Resultado esperado: multi-user.target para servidores).

1.2 Telemetría del Sistema (Punto 2)
Se recolectó la información clave del kernel y los recursos del host.

Versión del Kernel: uname -r (Identificación de la versión del núcleo de Linux para parches de seguridad).

Tiempo de Encendido (Uptime): uptime -p (Medición de la Alta Disponibilidad del servidor).

Uso de Memoria: free -h (Diagnóstico de la carga de recursos (RAM y SWAP)).

1.3 Docker Bajo Escáner (Punto 3)
Se auditó el estado del despliegue multicontenedor de WordPress (Misión MD_4353.mis) para identificar el mapeo de puertos y la salud de los servicios.

Comando de Diagnóstico: docker ps -a

Información Requerida: Se listaron los nombres (wordpress_app, wordpress_db), la imagen (wordpress:latest, mariadb:10.6), el estado (Up) y los puertos mapeados (8080->80/tcp).

2. EXPLORACIÓN AVANZADA Y SCRIPTING
2.1 Exploración de Archivos (Punto 4)
Se demostró la habilidad de búsqueda avanzada en sistemas de archivos.

Procedimiento: Se utilizó el comando find para localizar el patrón "starfleet" en el sistema.

Comando Clave de Búsqueda:

Bash

sudo find / -type f -iname "*starfleet*" 2>/dev/null
Conclusión: Se documenta la traza de auditoría del primer archivo encontrado, rompiendo el bucle de búsqueda.

2.2 Script de Diagnóstico (Punto 5)
Se creó el script diagnostico.sh para demostrar el dominio del control de flujo doble, un requisito de programación esencial:

Modo Capitán Kirk (Menú): Se utiliza el case dentro de un bucle while true para un interface interactivo.

Modo Jefe Scotty (Argumento): Se utiliza la variable $# para detectar la ejecución directa (sin menú) y $1 para pasar la opción deseada.

Comandos Clave de Ejecución:

Bash

# Ejecución interactiva (Modo Capitán Kirk)
./diagnostico.sh

# Ejecución por argumento (Modo Jefe Scotty)
./diagnostico.sh 2
3. REFLEXIÓN Y CONCLUSIÓN DE AUDITORÍA (Punto 6)
Es crucial adoptar una mentalidad de auditoría proactiva que trasciende las instrucciones explícitas. La exploración garantiza la integridad del sistema y previene Puntos Únicos de Fallo (SPOF), lo cual es fundamental para asegurar la estabilidad y seguridad de la Flota Estelar. La curiosidad es la diferencia entre un operador y un ingeniero de sistemas competente que garantiza la seguridad y la alta disponibilidad.
