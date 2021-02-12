FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

ENV AUTOINDEX=on

RUN apk update && apk upgrade && apk add --no-cache bash wget openrc vsftpd openssl db-doc db db-utils

RUN mkdir /etc/vsftpd/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/vsftpd/ssl/vsftpd.key -out \
/etc/vsftpd/ssl/vsftpd.crt -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=clde-ber/CN=helloworld"
RUN chown root:root /etc/vsftpd/ssl/vsftpd.crt && chmod 600 /etc/vsftpd/ssl/vsftpd.crt
RUN chown root:root /etc/vsftpd/ssl/vsftpd.key && chmod 600 /etc/vsftpd/ssl/vsftpd.key

RUN mkdir -p /srv/ftp && mkdir -p /etc/vsftpd/vsftpd_user_conf && mkdir -p var/run/vsftpd

COPY vsftpd.conf etc/vsftpd/vsftpd.conf
RUN touch /etc/vsftpd/chroot.list && echo -en "clde-ber\n" > /etc/vsftpd/chroot.list

COPY clde-ber.conf etc/vsftpd/vsftpd_user_conf

RUN touch etc/pam.d/vsftpd
#echo -e "#auth required /lib64/security/pam_userdb.so db=/etc/vsftpd/login\n#account required /lib64/security/pam_userdb.so db=/etc/vsftpd/login" >  etc/pam.d/vsftpd && \
#touch etc/vsftpd/login.txt && \
#echo -e "clde-ber\npassword" > etc/vsftpd/login.txt && \
#db_load -T -t hash -f /etc/vsftpd/login.txt /etc/vsftpd/login.db && \
#chmod 600 /etc/vsftpd/login.* && \
RUN touch etc/vsftpd.user_list && echo -e "clde-ber\npassword" > etc/vsftpd.user_list && chmod 600 etc/vsftpd.user_list
RUN adduser clde-ber -D && echo -e "password\npassword" | passwd clde-ber

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh