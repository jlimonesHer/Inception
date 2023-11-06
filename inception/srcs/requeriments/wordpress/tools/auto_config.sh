#!/bin/bash
sleep 3
# Cambiar al directorio de WordPress
cd /var/www/wordpress

# Descargar WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Verificar si wp-config.php existe
cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

# if [ ! -f wp-config.php ]; then
    # Crear el archivo wp-config.php si no existe

	cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
	sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" /var/www/wordpress/wp-config.php
	sed -i "s/localhost/mariadb.srcs_inception/g" /var/www/wordpress/wp-config.php
	sed -i "s/username_here/$WORDPRESS_DB_USER/g" /var/www/wordpress/wp-config.php
	sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" /var/www/wordpress/wp-config.php
    wp core download --path=/var/www/wordpress --allow-root
	wp core install --allow-root --url=jlimones.42.fr --title=$WORDPRESS_DB_USER \
		--admin_user=$WORDPRESS_DB_USER --admin_password=$WORDPRESS_DB_PASSWORD \
		--admin_email=$WORDPRESS_DB_EMAIL --path=/var/www/wordpress

	wp user create $WORDPRESS_DB_USER $WORDPRESS_DB_EMAIL --user_pass=$WORDPRESS_DB_PASSWORD \
		--role=author --allow-root --path=/var/www/wordpress
# else
#     echo "El archivo wp-config.php ya existe."
# fi
# Iniciar el servidor PHP-FPM (usando la ruta completa)
/usr/sbin/php-fpm7.3 -y /etc/php/7.3/fpm/php-fpm.conf -F
