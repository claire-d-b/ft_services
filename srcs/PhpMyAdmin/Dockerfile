FROM alpine

RUN apt-get -y update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get install -y php php-fpm wget
RUN apt-get install -y php7.3-mysql

RUN cd /var/www/html/ && wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz \
&& tar -xvzf phpMyAdmin-5.0.2-english.tar.gz && mv phpMyAdmin-5.0.2-english phpmyadmin && rm phpMyAdmin-5.0.2-english.tar.gz
COPY srcs/config_php var/www/html/phpmyadmin/config.inc.php
RUN rm /etc/php/7.3/fpm/php.ini
COPY srcs/php.ini /etc/php/7.3/fpm/php.ini