#!/bin/sh
sudo usermod -aG docker $USER && newgrp docker
sudo apt-get -y update && apt-get -y upgrade
sudo apt-get -y install wget
sudo apt-get -y install curl
sudo apt-get -y install openssl
wget -O kubernetes https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes.tar.gz
wget -O kubernetes-src https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-src.tar.gz
wget -O kubernetes-client-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-client-linux-amd64.tar.gz
wget -O kubernetes-server-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-server-linux-amd64.tar.gz
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl
sudo chmod 777 /usr/local/bin/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo apt-get update && sudo apt-get install -y sudo apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
bash