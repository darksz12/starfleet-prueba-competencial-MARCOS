#!/bin/bash
APACHE_STATUS=$(systemctl is-active apache2)
MYSQL_STATUS=$(systemctl is-active mariadb)

PHP_VERSION=$(php -v 2>/dev/null | head -n 1 | awk '{print $2}')
DOCKER_VERSION=$(docker -v 2>/dev/null | awk '{print $3}' | sed 's/,//')
KERNEL_VERSION=$(uname -r)
UPTIME=$(uptime -p 2>/dev/null | sed 's/up //')
FECHA_ESTELAR=$(date +"%Y.%m%d-%H%M")
HOST_NAME=$(hostname)

JSON_DATA=$(cat <<EOF
{
  "timestamp": "$FECHA_ESTELAR",
  "servicios": {
    "apache": "$APACHE_STATUS",
    "mysql": "$MYSQL_STATUS"
  },
  "versiones": {
    "php": "$PHP_VERSION",
    "docker": "$DOCKER_VERSION",
    "kernel": "$KERNEL_VERSION"
  },
  "sistema": {
    "uptime": "$UPTIME",
    "host": "$HOST_NAME"
  }
}
EOF
)
echo "$JSON_DATA" | jq . > /var/www/html/telemetria.json
