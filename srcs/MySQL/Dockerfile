FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget
RUN apk add --no-cache mysql mariadb mariadb-backup mariadb-bench mariadb-client mariadb-common mariadb-dev mariadb-doc mariadb-embedded mariadb-embedded-dev mariadb-mytop mariadb-openrc mariadb-plugin-rocksdb mariadb-server-utils mariadb-static mariadb-test mysql-bench mysql-client

COPY my.cnf /etc/my.cnf
RUN chmod u+rwx /etc/my.cnf.d

#RUN /etc/init.d/mariadb setup

COPY init_mysql.sh .
RUN chmod +x init_mysql.sh

COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

ENTRYPOINT bash docker-entrypoint.sh