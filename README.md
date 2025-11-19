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
