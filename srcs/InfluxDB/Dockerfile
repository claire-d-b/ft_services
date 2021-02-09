FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget influxdb

COPY create_db.sh .
RUN chmod +x create_db.sh

RUN apk add telegraf
RUN telegraf config > telegraf.conf

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh