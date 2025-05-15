FROM	debian:bullseye

RUN	apt update -y && apt upgrade -y && apt install nginx -y && apt install openssl -y

RUN	mkdir -p /etc/nginx/ssl

RUN	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key 	-subj "/C=FR/ST=NOR/L=LeHavre/O=42/OU=42/CN=mvannest.42.fr/UID=mvannest"

COPY	conf/default /etc/nginx/sites-available/.

CMD	["nginx", "-g", "daemon off;"]
