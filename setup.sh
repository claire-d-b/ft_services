#!/bin/sh
minikube delete
minikube start --driver=docker #--base-image="gcr.io/k8s-minikube/kicbase:v0.0.15-snapshot4@sha256:ef1f485b5a1cfa4c989bc05e153f0a8525968ec999e242efff871cbb31649c16"
eval $(minikube docker-env)
minikube addons enable dashboard
minikube addons enable metrics-server
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
#if [ -e $metallb ] ;
#else
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
#fi
kubectl apply -f config.yaml

#docker build -t image-nginx ./srcs/Nginx/
#docker build -t image-vsftpd ./srcs/FTPS/
#docker build -t image-grafana ./srcs/Grafana/
#docker build -t image-influxdb ./srcs/InfluxDB/
#docker build -t image-nwordpress ./srcs/WordPress/
docker build -t image-phpmyadmin ./srcs/PhpMyAdmin/
docker build -t image-mysql ./srcs/MySQL/

kubectl apply -f ./srcs/PhpMyAdmin/phpmyadmin.yaml
#kubectl apply -f ./srcs/Nginx/nginx.yaml
#kubectl apply -f ./srcs/FTPS/vsftpd.yaml
#kubectl apply -f ./srcs/Grafana/grafana.yaml
#kubectl apply -f ./srcs/WordPress/wordpress.yaml
#kubectl apply -f ./srcs/InfluxDB/influxdb.yaml
kubectl apply -f ./srcs/MySQL/mysql.yaml
bash