FROM	debian:bullseye

RUN	apt update -y && apt upgrade -y && apt install mariadb-server -y

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY	tools/script.sh .

RUN	mkdir -p /run/mysqld && chmod a+x script.sh

RUN	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

EXPOSE	3306

ENTRYPOINT	["./script.sh"]

#CMD	["./script.sh"]
