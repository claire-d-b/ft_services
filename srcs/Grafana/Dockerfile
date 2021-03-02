FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget curl

RUN apk add grafana

COPY dashb.yaml /usr/share/grafana/conf/provisioning/dashboards/
COPY ds.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY dashboard_ftps.json /usr/share/grafana/conf/provisioning/dashboards/
COPY dashboard_grafana.json /usr/share/grafana/conf/provisioning/dashboards/
COPY dashboard_mysql.json /usr/share/grafana/conf/provisioning/dashboards/
COPY dashboard_nginx.json /usr/share/grafana/conf/provisioning/dashboards/
COPY dashboard_pma.json /usr/share/grafana/conf/provisioning/dashboards/
COPY dashboard_wp.json /usr/share/grafana/conf/provisioning/dashboards/
COPY dashboard_influx.json /usr/share/grafana/conf/provisioning/dashboards/

COPY docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT bash docker-entrypoint.sh