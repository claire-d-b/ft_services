FROM alpine:latest

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget php7 php7-fpm php7-opcache nginx
RUN apk add --no-cache php7-gd php7-mysqli php7-zlib php7-curl

RUN mkdir -p /var/www/html
RUN cd /var/www/html && wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz \
&& tar -xvzf phpMyAdmin-5.0.2-english.tar.gz && mv phpMyAdmin-5.0.2-english phpmyadmin && rm phpMyAdmin-5.0.2-english.tar.gz
COPY config_php var/www/html/phpmyadmin/config.inc.php
COPY php.ini /etc/php/7.3/fpm/php.ini

COPY nginx.conf /etc/nginx/sites-available/default
RUN  cd /etc/nginx/ && mkdir sites-enabled && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh