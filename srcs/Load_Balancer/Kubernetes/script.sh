#!/bin/sh
#usermod -aG docker $USER && newgrp docker
apt-get -y update #&& apt-get -y upgrade
#apt-get install -y apt-transport-https
#apt-get -y install wget
#apt-get -y install curl
#apt-get -y install openssl
#wget -O kubernetes https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes.tar.gz
#wget -O kubernetes-src https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-src.tar.gz
#wget -O kubernetes-client-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-client-linux-amd64.tar.gz
#wget -O kubernetes-server-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-server-linux-amd64.tar.gz
#curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
#mkdir -p /usr/local/bin/
#install minikube /usr/local/bin/
#curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl
#chmod 777 /usr/local/bin/kubectl
#chmod +x ./kubectl
#mv ./kubectl /usr/local/bin/kubectl
#apt-get update && apt-get install -y apt-transport-https
#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
#apt-get install -y kubectl
#cd ../../Nginx && docker run -tid --name nginx image_nginx 
#cd ../FTPS && docker run -tid --name vsftpd image_vsftpd
#cd ../Grafana && docker run -tid --name grafana image_grafana
#cd ../PhpMyAdmin && docker run -tid --name phpmyadmin image_phpmyadmin
#cd ../WordPress && docker run -tid --name wordpress image_wordpress
#cd ../InfluxDB && docker run -tid --name influxdb image_influxdb
#cd ../MySQL && docker run -tid --name mysql image_mysql
#cd ../Load_Balancer/Kubernetes
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
cat <<EOF | kubectl create -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 192.168.49.1-192.168.49.254
EOF
minikube start --driver=docker
eval $(minikube docker-env)
minikube addons enable dashboard
minikube addons enable metrics-server
kubectl taint nodes --all node-role.kubernetes.io/master-
cd ../../Nginx && docker build -t image-nginx .
cd ../FTPS && docker build -t image-vsftpd .
cd ../Grafana && docker build -t image-grafana .
cd ../PhpMyAdmin && docker build -t image-phpmyadmin .
cd ../WordPress && docker build -t image-wordpress .
cd ../InfluxDB && docker build -t image-influxdb .
cd ../MySQL && docker build -t image-mysql .

cd ../Nginx/
#kubectl create deployment nginx --image=image-nginx
#kubectl set env deployment/nginx
kubectl apply -f nginx.yaml
kubectl run nginx --image=image-nginx --image-pull-policy='Never'
kubectl expose deployment nginx --port=80 --port=443 --type=LoadBalancer

cd ../FTPS/
#kubectl create deployment vsftpd --image=image-vsftpd
#kubectl set env deployment/vsftpd
kubectl apply -f vsftpd.yaml
kubectl run vsftpd --image=image-vsftpd --image-pull-policy='Never'
kubectl expose deployment vsftpd --port=21 --type=LoadBalancer

cd ../Grafana/
#kubectl create deployment grafana --image=image-grafana
#kubectl set env deployment/grafana
kubectl apply -f grafana.yaml
kubectl run grafana --image=image-grafana --image-pull-policy='Never'
kubectl expose deployment grafana --port=3000 --type=LoadBalancer

cd ../PhpMyAdmin/
#kubectl create deployment phpmyadmin --image=image-phpmyadmin 
#kubectl set env deployment/phpmyadmin
kubectl apply -f phpmyadmin.yaml
kubectl run phpmyadmin --image=image-phpmyadmin --image-pull-policy='Never'
kubectl expose deployment phpmyadmin --port=5000 --type=LoadBalancer

cd ../WordPress/
#kubectl create deployment wordpress --image=image-wordpress 
#kubectl set env deployment/wordpress
kubectl apply -f wordpress.yaml
kubectl run wordpress --image=image-wordpress --image-pull-policy='Never'
kubectl expose deployment wordpress --port=5050 --type=LoadBalancer

cd ../InfluxDB/
#kubectl create deployment influxdb --image=image-influxdb 
#kubectl set env deployment/influxdb
kubectl apply -f influxdb.yaml
kubectl run influxdb --image=image-influxdb --image-pull-policy='Never'
kubectl expose deployment influxdb --port=3000 --type=ClusterIP

cd ../MySQL/
#kubectl create deployment mysql --image=image-mysql
#kubectl set env deployment/mysql
kubectl apply -f mysql.yaml
kubectl run mysql --image=image-mysql --image-pull-policy='Never'
kubectl expose deployment mysql --port=5050 --type=ClusterIP

cd ../Load_Balancer/Kubernetes
bash