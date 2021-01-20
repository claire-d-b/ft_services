FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget php7 php7-fpm php7-opcache nginx
RUN apk add --no-cache php7-gd php7-mysqli php7-zlib php7-curl

RUN mkdir -p /var/www/html
RUN cd /var/www/html && wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz \
&& tar -xvzf phpMyAdmin-5.0.2-english.tar.gz && mv phpMyAdmin-5.0.2-english phpmyadmin && rm phpMyAdmin-5.0.2-english.tar.gz

RUN chmod -R 777 /var/www/html/ && chmod -R 777 /var/www/html/phpmyadmin/

RUN openrc && touch /run/openrc/softlevel

RUN rc-update add nginx default

RUN rc-service nginx restart

COPY config_php var/www/html/phpmyadmin/config.inc.php

COPY php.ini /etc/php7/php.ini

COPY nginx.conf /etc/nginx/http.d/nginx.conf

COPY docker-entrypoint.sh docker-entrypoint.sh

ENTRYPOINT ./docker-entrypoint.sh
