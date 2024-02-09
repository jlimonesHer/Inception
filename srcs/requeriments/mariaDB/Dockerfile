# Usa Debian Buster como imagen base
FROM debian:buster

# Actualiza el sistema y establece variables de entorno
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copia un archivo de configuración personalizado si es necesario
COPY /conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/.env /.env
COPY ./tools/script.sh /script.sh

RUN chmod +x /script.sh

#xargs es una utilidad que se utiliza para convertir líneas de texto en argumentos para comandos.
RUN		export $(cat /.env | xargs) && \
		/script.sh
# Expone el puerto por defecto de MariaDB (3306)
EXPOSE 3306

# Inicia el servicio de MariaDB
CMD ["mysqld_safe"]