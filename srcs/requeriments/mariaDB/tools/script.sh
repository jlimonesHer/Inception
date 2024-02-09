#!/bin/bash
# Iniciar el servicio MySQL
service mysql start
# Esperar a que el servicio MySQL se inicie completamente
while ! mysqladmin ping -hlocalhost --silent; do
    echo "esperando"
    sleep 1
done
mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;"
mysql -e "CREATE USER IF NOT EXISTS '$WORDPRESS_DB_USER@wordpress.srcs_incetion' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO $WORDPRESS_DB_USER IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';"
mysql -e "ALTER USER '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';"
mysql -e "FLUSH PRIVILEGES;"


