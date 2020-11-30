#!/bin/sh
if [ "$AUTOINDEX" = "on" ] ;
then mv srcs/default_nginx_ai_on /etc/nginx/sites-available/default ;
else mv srcs/default_nginx_ai_off /etc/nginx/sites-available/default ;
fi
rm -rf /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default ;
service nginx reload
service nginx start
# -g sets global directives
# a daemon is a computer program that runs as a background process, rather than being under the direct control of an interactive user.
# daemon off directive prevents the container for stopping right after the command is executed, which would be the standard behavior of a conainter.
nginx -g daemon off;
bash