#!/bin/sh
apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade
apt-get -y install wget
apt-get -y install curl
wget -O kubernetes https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes.tar.gz
wget -O kubernetes-src https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-src.tar.gz
wget -O kubernetes-client-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-client-linux-amd64.tar.gz
wget -O kubernetes-server-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-server-linux-amd64.tar.gz
# On first install only
if [ "$KUBECTL" = "true" ] ;
then export KUBECTL="true";
else curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl ;
chmod +x ./kubectl ;
mv ./kubectl /usr/local/bin/kubectl ;
export KUBECONFIG=./.kube/config
fi
export KUBECTL="true"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
if [ "$SECRET" = "true" ] ;
then export SECRET="true";
else kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" ; 
fi
export SECRET="true"
bash