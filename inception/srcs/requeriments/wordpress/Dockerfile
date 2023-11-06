FROM debian:buster

# Actualizar el sistema y luego instalar las dependencias
RUN apt-get update
RUN apt-get upgrade -y 
RUN apt-get install -y wget curl php7.3 php-fpm php-mysql mariadb-client
RUN rm -rf /var/lib/apt/lists/*

# Descargar y configurar WordPress
RUN wget https://es.wordpress.org/wordpress-5.8.3-es_ES.tar.gz -P /var/www && \
    cd /var/www && tar -xzf wordpress-5.8.3-es_ES.tar.gz && rm wordpress-5.8.3-es_ES.tar.gz
# Copiar archivos de configuración
COPY conf/php-fpm.conf /etc/php/7.3/fpm/pool.d
COPY tools/auto_config.sh /auto_config.sh

# Dar permisos de ejecución al script
RUN chmod +x /auto_config.sh

# Crear directorio para PHP-FPM
RUN mkdir -p /run/php
RUN		useradd jlimones && groupadd glimones && usermod -aG glimones jlimones

# Indicar el puerto en el que se ejecutará PHP-FPM (puerto 9000)
EXPOSE 9000

# Entrypoint para ejecutar el script al iniciar el contenedor
CMD ["/auto_config.sh"]
