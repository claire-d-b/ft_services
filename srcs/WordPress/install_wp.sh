#!/bin/sh
cd var/www/html && wp core install --url=192.168.49.3:5050 --title=mysite --admin_user=admin --admin_email=admin@clde-ber.com
sleep 20
cd var/www/html && wp user update admin admin@clde-ber.com --role=administrator --user_pass=admin && wp user create user1 user1@clde-ber.com --role=editor --user_pass=user1 && \
wp user create user2 user2@clde-ber.com --role=editor --user_pass=user2
sleep 10