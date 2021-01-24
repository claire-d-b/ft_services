FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash wget openrc openssl nginx

RUN cd /etc/nginx/ && mkdir ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out \
/etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=clde-ber/CN=helloworld"

RUN mkdir /var/www/html
RUN cd /var/www/html/ && wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && touch .htaccess && chmod 660 .htaccess
RUN cd /var/www/html/wordpress/ && rm wp-config-sample.php
COPY wp-config.php /var/www/html/wordpress/
RUN cp -a /var/www/html/wordpress/. /var/www/html && cd /var/www/html && rm -rf wordpress
RUN cd /var/www/html/ && mkdir wp-content/upgrade
RUN cd /var/www/html/ && chown -R root /var/www/html && find /var/www/html -type d -exec chmod g+s {} \; \
&& chmod g+w /var/www/html/wp-content && chmod -R g+w /var/www/html/wp-content/themes && chmod -R g+w /var/www/html/wp-content/plugins
RUN cd /var/www/html/ && wget https://api.wordpress.org/secret-key/1.1/salt/
RUN cd /var/www/html/ && rm index.html

COPY nginx.conf srcs/nginx.conf

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh