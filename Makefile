# Nombre del archivo Docker Compose
DOCKER_COMPOSE_FILE := srcs/docker-compose.yml

DATA := /Users/jlimones/data
MARIADB_DATA_DIR := /Users/jlimones/data/mariadb
WORDPRESS_DATA_DIR := /Users/jlimones/data/wordpress

change_permissions:
	chmod 777 $(MARIADB_DATA_DIR)
	chmod 777 $(WORDPRESS_DATA_DIR)

# Nombre de la red Docker
NETWORK_NAME := inception

# Comando para crear las carpetas de datos
create-data-dirs:
	mkdir -p $(DATA)
	mkdir -p $(MARIADB_DATA_DIR)
	mkdir -p $(WORDPRESS_DATA_DIR)

# Nombre de la red Docker
NETWORK_NAME := inception

# Comando para iniciar los contenedores
start:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up
startd:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

# Comando para detener y eliminar los contenedores
stop:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

# Comando para ver los registros de los contenedores
logs:
	docker-compose -f $(DOCKER_COMPOSE_FILE) logs -f

# Comando para limpiar volúmenes y redes
clean: change_permissions
	rm -fr $(DATA)
	rm -fr $(WORDPRESS_DATA_DIR)
	rm -fr $(WORDPRESS_DATA_DIR)
	docker-compose -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans
	docker network rm $(NETWORK_NAME)

# Comando para reconstruir las imágenes de Docker
build:
	docker-compose -f $(DOCKER_COMPOSE_FILE) build

# Comando para ejecutar una shell dentro de un contenedor (ejemplo: make shell service=wordpress)
shell:
	docker-compose -f $(DOCKER_COMPOSE_FILE) exec $(service) sh

reset:
	docker compose -f ${DOCKER_COMPOSE_FILE} up --build --force-recreate

# Comando para listar los servicios
list-services:
	docker-compose -f $(DOCKER_COMPOSE_FILE) config --services

.PHONY: start stop logs clean build shell list-services
