FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget openssl php7 php7-fpm php7-opcache nginx
RUN apk add --no-cache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring

#RUN chmod -R 777 /var/www/html/ && chmod -R 777 /var/www/html/phpmyadmin/

#RUN openrc && touch /run/openrc/softlevel

#RUN rc-update add nginx default

#RUN rc-service nginx restart

RUN cd /etc/nginx/ && mkdir ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out \
/etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=clde-ber/CN=helloworld"

RUN mkdir -p /var/www/html
RUN cd /var/www/html && wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz \
&& tar -xvzf phpMyAdmin-5.0.4-english.tar.gz && mv phpMyAdmin-5.0.4-english phpmyadmin && rm phpMyAdmin-5.0.4-english.tar.gz

RUN apk add --no-cache phpmyadmin

COPY config_php /usr/share/phpmyadmin/config.inc.php
RUN rm -rf /usr/share/phpmyadmin/config.sample.inc.php
COPY config_php /var/www/html/phpmyadmin/config.inc.php
RUN rm -rf /var/www/html/phpmyadmin/config.sample.inc.php

COPY nginx.conf /etc/nginx/http.d/nginx.conf

RUN sed -i "s|;pid\s*=\s*run/php-fpm7.pid|pid = run/php-fpm7.pid|g" ./etc/php7/php-fpm.conf \
&& sed -i "s|;daemonize\s*=\s*yes|daemonize = yes|g" ./etc/php7/php-fpm.conf \
&& sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = nginx|g" ./etc/php7/php-fpm.d/www.conf \
&& sed -i "s|;listen.group\s*=\s*nobody|listen.group = nginx|g" ./etc/php7/php-fpm.d/www.conf \
&& sed -i "s|;listen.mode\s*=\s*0660|listen.mode = 0660|g" ./etc/php7/php-fpm.d/www.conf \
&& sed -i "s|user\s*=\s*nobody|user = nginx|g" ./etc/php7/php-fpm.d/www.conf \
&& sed -i "s|group\s*=\s*nobody|group = nginx|g" ./etc/php7/php-fpm.d/www.conf \
&& sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" ./etc/php7/php-fpm.d/www.conf
#&& sed -i "s|;listen.allowed_clients\s*=\s*127.0.0.1|listen.allowed_clients = 127.0.0.1|g" ./etc/php7/php-fpm.d/www.conf

COPY php.ini /etc/php7/php.ini

COPY docker-entrypoint.sh docker-entrypoint.sh

ENTRYPOINT ./docker-entrypoint.sh
