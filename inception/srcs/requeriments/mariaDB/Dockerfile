FROM debian:buster
RUN     apt update -y
RUN     apt upgrade -y
RUN     apt install mariadb-server -y
RUN		mkdir -p /var/run/mysqld && \
		chown -R mysql:mysql /var/run/mysqld && \
		chown 777 /var/run/mysqld

COPY /conf/my.cnf	/my.cnf
COPY ./tools/script.sh /script.sh

RUN chmod +x /script.sh

RUN /script.sh

EXPOSE 3306

CMD	["mysqld"]