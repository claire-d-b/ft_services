FROM alpine:latest

ENV AUTOINDEX=on

RUN apk update && apk upgrade && apk add --no-cache bash wget openrc vsftpd

RUN mkdir /srv/ftp && chown nobody:nogroup /srv/ftp && echo "anon" | tee /srv/ftp/anon.txt

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh