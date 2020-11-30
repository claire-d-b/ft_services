FROM alpine:latest

ENV AUTOINDEX=on

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget nginx openssl

RUN apk -L info nginx | grep 'default'
#RUN unlink /etc/nginx/sites-enabled/default && mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default_old
RUN mkdir srcs
COPY default_nginx_ai_on /srcs/default_nginx_ai_on
COPY default_nginx_ai_off /srcs/default_nginx_ai_off
COPY default_nginx_ai_on /etc/nginx/sites-available/default
RUN cd /etc/nginx/ && mkdir sites-enabled && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
RUN cd /etc/nginx/ && mkdir ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out \
/etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=clde-ber/CN=helloworld"

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh