#!/bin/bash
# mysql_install_db
# Iniciar el servicio MySQL
service mysql start
# Esperar a que el servicio MySQL se inicie completamente
# while ! mysqladmin ping -hlocalhost --silent; do
#     echo "esperando"
#     sleep 1
# done
# mysql -e "FLUSH PRIVILEGES;"
echo "FLUSH 1"
sleep 5
mysql -e "CREATE DATABASE IF NOT EXISTS '$WORDPRESS_DB_NAME';"

echo "base de datos creada"
sleep 5
mysql -e "CREATE USER IF NOT EXISTS '$WORDPRESS_DB_USER'@'localhost' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
echo "usuario creado"
sleep 5
mysql -e "GRANT ALL PRIVILEGES ON '${WORDPRESS_DB_NAME}'.* TO '${WORDPRESS_DB_USER}' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}'"
echo "Privilegios dados"
sleep 5
echo $WORDPRESS_DB_PASSWORD
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
sleep 5
mysql -e "FLUSH PRIVILEGES;"
echo "Privilegios actualizados"
sleep 5
echo "Fin del script"

