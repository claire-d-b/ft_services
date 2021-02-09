FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget

#RUN wget http://dl-cdn.alpinelinux.org/alpine/edge/testing/x86_64/grafana-image-renderer-2.0.0-r0.apk
RUN wget http://dl-cdn.alpinelinux.org/alpine/edge/testing/x86_64/grafana-image-renderer-openrc-2.0.0-r0.apk
RUN apk add grafana

COPY change_pw.sh .
RUN chmod +x change_pw.sh

RUN apk add telegraf
RUN telegraf config > telegraf.conf

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh