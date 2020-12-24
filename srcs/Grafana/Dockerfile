FROM alpine:latest

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget

RUN wget http://dl-cdn.alpinelinux.org/alpine/edge/testing/x86_64/grafana-image-renderer-2.0.0-r0.apk
RUN wget http://dl-cdn.alpinelinux.org/alpine/edge/testing/x86_64/grafana-image-renderer-openrc-2.0.0-r0.apk
RUN apk add grafana-image-renderer-2.0.0-r0.apk

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh