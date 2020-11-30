FROM alpine:latest

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget influxdb

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh