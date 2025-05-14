FROM	debian:bullseye

RUN	apt update -y && apt upgrade -y && apt install mariadb-server -y

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY	tools/init.sql	/etc/mariadb/init.sql
COPY	tools/script.sh .

RUN	mkdir /run/mysqld && chmod +x script.sh

CMD	["./scipt.sh"]
