#!/bin/sh
usermod -aG docker $USER && newgrp docker
apt-get -y update && apt-get -y upgrade
apt-get -y install wget
apt-get -y install curl
apt-get -y install openssl
wget -O kubernetes https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes.tar.gz
wget -O kubernetes-src https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-src.tar.gz
wget -O kubernetes-client-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-client-linux-amd64.tar.gz
wget -O kubernetes-server-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-server-linux-amd64.tar.gz
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
mkdir -p /usr/local/bin/
install minikube /usr/local/bin/
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl
chmod 777 /usr/local/bin/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl
cd ../../Nginx && docker build -t image_nginx .
cd ../FTPS && docker build -t image_vsftpd .
cd ../Grafana && docker build -t image_grafana .
cd ../PhpMyAdmin && docker build -t image_phpmyadmin .
cd ../WordPress/ && docker build -t image_wordpress .
cd ../InfluxDB && docker build -t image_influxdb .
cd ../MySQL && docker build -t image_mysql .
cd ../Nginx && docker run -tid --name nginx image_nginx 
cd ../FTPS && docker run -tid --name vsftpd image_vsftpd
cd ../Grafana && docker run -tid --name grafana image_grafana
cd ../PhpMyAdmin && docker run -tid --name phpmyadmin image_phpmyadmin
cd ../WordPress && docker run -tid --name wordpress image_wordpress
cd ../InfluxDB && docker run -tid --name influxdb image_influxdb
cd ../MySQL && docker run -tid --name mysql image_mysql
cd ../Load_Balancer/Kubernetes
bash