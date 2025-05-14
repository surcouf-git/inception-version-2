FROM	debian:bullseye

RUN	apt update -y && apt upgrade -y && apt install nginx -y

COPY	default /etc/nginx/sites-available/.

CMD	["nginx", "-g", "daemon off;"]
