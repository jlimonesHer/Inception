# get image debian buster
FROM    debian:buster

RUN     apt update -y
RUN     apt upgrade -y
#comentar
        # RUN apt install vim -y    
        # RUN apt install curl -y

RUN     apt install nginx -y

RUN     mkdir -p /etc/nginx/ssl

RUN     apt install openssl -y

# # SSL is a web protocol used to wrap normal traffic with encrypted coverage.
# # openssl: Command tool to create and manage ssl keys
# # req: This subcommand specifies that we want to use certificate signing management
# # -x509: indicates that we want to create a self-signed certificate.
# # -nodes: tells Openssl that we do not want a password so that the server can read the file without user intervention.
# # days365: indicates the days that the certificate will be valid.
# # newkey rsa:4096: tells the program to generate a certificate and key at the same time. Make the RSA 4096 bits long.
# # -out: Path to the newly created certificate
# # -keyout: tells openssl where to place the generated private-key file we are creating.
# # subj: country, State, Locality, Organization Name, ORGanizational Unit Name, Common Name, Email Address;

RUN     openssl req -x509 -sha256 -nodes \
        -days 365 -newkey rsa:4096 \
        -out /etc/nginx/ssl/inception.crt \
        -keyout  /etc/nginx/ssl/inception.key \
        -subj "/C=ES/ST=Andalucia/L=Malaga/O=42/OU=42/CN=jlimones.42.fr/UID=jlimones"

# creamos una carpeta para los archivos de configuracion de nginx
RUN     mkdir -p /var/run/nginx

COPY    ./conf/nginx.conf /etc/nginx/nginx.conf

#permisos de raiz y usuario principal
RUN chmod -R 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]