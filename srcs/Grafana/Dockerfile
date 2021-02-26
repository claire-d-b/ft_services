FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget curl

RUN apk add grafana

COPY dashb.yaml /usr/share/grafana/conf/provisioning/dashboards/
COPY ds.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY dashboard.json /usr/share/grafana/conf/provisioning/dashboards/

COPY change_pw.sh .
RUN chmod +x change_pw.sh

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh