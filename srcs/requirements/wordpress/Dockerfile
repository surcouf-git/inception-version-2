FROM	debian:bullseye

RUN	apt update -y && apt upgrade -y && apt install -y php-fpm php-mysqli curl

RUN	mkdir -p /run/php

COPY	config/www.conf /etc/php/7.4/fpm/pool.d/.
COPY	tools/wordpress_script.sh .

RUN	chmod +x wordpress_script.sh

CMD	["php-fpm7.4", "-F"]
