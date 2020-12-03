FROM alpine:latest


RUN apk update && apk upgrade && apk add --no-cache bash openrc wget
RUN cd /var/lib/ && apk add --no-cache mysql mysql-bench mysql-client libcrypto1.1 libgcc libssl1.1 libstdc++ mariadb-common ncurses-libs zlib libaio libcurl libxml2 linux-pam pcre2 xz-libs mariadb mariadb-client

COPY my.cnf /etc/my.cnf
RUN chmod u+rwx /etc/my.cnf.d

RUN mysql_install_db --user=root --ldata=/var/lib/mysql

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh