#!/bin/sh
docker system prune
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
cd ../../Nginx && docker build -t image-nginx .
cd ../FTPS && docker build -t image-vsftpd .
cd ../Grafana && docker build -t image-grafana .
cd ../PhpMyAdmin && docker build -t image-phpmyadmin .
cd ../WordPress/ && docker build -t image-wordpress .
cd ../InfluxDB && docker build -t image-influxdb .
cd ../MySQL && docker build -t image-mysql .
#cd ../Nginx && docker run -tid --name nginx image_nginx 
#cd ../FTPS && docker run -tid --name vsftpd image_vsftpd
#cd ../Grafana && docker run -tid --name grafana image_grafana
#cd ../PhpMyAdmin && docker run -tid --name phpmyadmin image_phpmyadmin
#cd ../WordPress && docker run -tid --name wordpress image_wordpress
#cd ../InfluxDB && docker run -tid --name influxdb image_influxdb
#cd ../MySQL && docker run -tid --name mysql image_mysql
#cd ../Load_Balancer/Kubernetes
minikube start --driver=docker
cd ../Nginx && kubectl create deployment --image=image-nginx nginx
kubectl set env deployment/nginx DOMAIN=cluster
kubectl expose deployment nginx --port=80 --port=443 --name=nginx --type=LoadBalancer
kubectl run -ti nginx --image=nginx --restart='Always' --attach=false
cd ../FTPS && kubectl create deployment --image=image-vsftpd vsftpd
kubectl set env deployment/vsftpd DOMAIN=cluster
kubectl expose deployment vsftpd --port=21 --port=443 --name=vsftpd --type=LoadBalancer
kubectl run -ti vsftpd --image=vsftpd --restart='Always' --attach=false
cd ../Grafana && kubectl create deployment --image=image-grafana grafana
kubectl set env deployment/grafana DOMAIN=cluster
kubectl expose deployment grafana --port=3000 --name=grafana --type=LoadBalancer
kubectl run -ti grafana --image=grafana --restart='Always' --attach=false
cd ../PhpMyAdmin && kubectl create deployment --image=image-phpmyadmin phpmyadmin
kubectl set env deployment/phpmyadmin DOMAIN=cluster
kubectl expose deployment phpmyadmin --port=5000 --name=phpmyadmin --type=LoadBalancer
kubectl run -ti phpmyadmin --image=phpmyadmin --restart='Always' --attach=false
cd ../WordPress && kubectl create deployment --image=image-wordpress wordpress
kubectl set env deployment/wordpress DOMAIN=cluster
kubectl expose deployment wordpress --port=5050 --name=worpress --type=LoadBalancer
kubectl run -ti wordpress --image=wordpress --restart='Always' --attach=false
cd ../InfluxDB && kubectl create deployment --image=image-influxdb influxdb
kubectl set env deployment/influxdb DOMAIN=cluster
kubectl expose deployment influxdb --port=3000 --name=influxdb --type=ClusterIP
kubectl run -ti influxdb --image=influxdb --restart='Always' --attach=false
cd ../MySQL && kubectl create deployment --image=image-mysql mysql
kubectl set env deployment/mysql DOMAIN=cluster
kubectl expose deployment mysql --port=5050 --type=ClusterIP
kubectl run -ti mysql --image=mysql --restart='Always' --attach=false
cd ../Load_Balancer/Kubernetes
bash