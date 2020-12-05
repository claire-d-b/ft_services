#!/bin/sh
apt-get -y update && apt-get -y upgrade
apt-get -y install wget
apt-get -y install curl
apt-get -y install openssl
wget -O kubernetes https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes.tar.gz
wget -O kubernetes-src https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-src.tar.gz
wget -O kubernetes-client-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-client-linux-amd64.tar.gz
wget -O kubernetes-server-linux-amd64 https://kubernetes.io/docs/setup/release/notes/\#downloads-for-v1-19-0/kubernetes-server-linux-amd64.tar.gz
openssl rand -writerand /home/user42/.rnd
openssl genrsa -out john.key 2048
openssl req -new -key john.key -out john.csr -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=clde-ber/CN=helloworld"
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: john
spec:
  groups:
  - system:authenticated
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZVzVuWld4aE1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQTByczhJTHRHdTYxakx2dHhWTTJSVlRWMDNHWlJTWWw0dWluVWo4RElaWjBOCnR2MUZtRVFSd3VoaUZsOFEzcWl0Qm0wMUFSMkNJVXBGd2ZzSjZ4MXF3ckJzVkhZbGlBNVhwRVpZM3ExcGswSDQKM3Z3aGJlK1o2MVNrVHF5SVBYUUwrTWM5T1Nsbm0xb0R2N0NtSkZNMUlMRVI3QTVGZnZKOEdFRjJ6dHBoaUlFMwpub1dtdHNZb3JuT2wzc2lHQ2ZGZzR4Zmd4eW8ybmlneFNVekl1bXNnVm9PM2ttT0x1RVF6cXpkakJ3TFJXbWlECklmMXBMWnoyalVnald4UkhCM1gyWnVVV1d1T09PZnpXM01LaE8ybHEvZi9DdS8wYk83c0x0MCt3U2ZMSU91TFcKcW90blZtRmxMMytqTy82WDNDKzBERHk5aUtwbXJjVDBnWGZLemE1dHJRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBR05WdmVIOGR4ZzNvK21VeVRkbmFjVmQ1N24zSkExdnZEU1JWREkyQTZ1eXN3ZFp1L1BVCkkwZXpZWFV0RVNnSk1IRmQycVVNMjNuNVJsSXJ3R0xuUXFISUh5VStWWHhsdnZsRnpNOVpEWllSTmU3QlJvYXgKQVlEdUI5STZXT3FYbkFvczFqRmxNUG5NbFpqdU5kSGxpT1BjTU1oNndLaTZzZFhpVStHYTJ2RUVLY01jSVUyRgpvU2djUWdMYTk0aEpacGk3ZnNMdm1OQUxoT045UHdNMGM1dVJVejV4T0dGMUtCbWRSeEgvbUNOS2JKYjFRQm1HCkkwYitEUEdaTktXTU0xMzhIQXdoV0tkNjVoVHdYOWl4V3ZHMkh4TG1WQzg0L1BHT0tWQW9FNkpsYWFHdTlQVmkKdjlOSjVaZlZrcXdCd0hKbzZXdk9xVlA3SVFjZmg3d0drWm89Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF
kubectl get csr
kubectl certificate approve john
kubectl get csr/john -o yaml
# On first install only
kubectl config --kubeconfig=./.kube/config set-cluster development --server=http://localhost/80 --client-key=john.key
kubectl config --kubeconfig=./.kube/config set-credentials root --username=root --password='' --client-key=john.key
kubectl config --kubeconfig=./.kube/config set-context dev-cluster --cluster=development --namespace=cluster --user=root --client-key=john.key
kubectl config --kubeconfig=./.kube/config use-context dev-cluster --client-key=john.key # definit le contexte courant
if [ "$KUBECTL" = "true" ] ;
then export KUBECTL="true";
else curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl ;
chmod 777 ./kubectl ;
mv ./kubectl /usr/local/bin/kubectl ;
# kubectl config --kubeconfig=./.kube/config set-cluster development --server=https://localhost/8080 --insecure-skip-tls-verify ;
# kubectl config --kubeconfig=./.kube/config set-credentials developer --username=dev --password='' ;
# kubectl config --kubeconfig=./.kube/config set-context dev-cluster --cluster=development --namespace=cluster --user=developer ;
#export KUBECONFIG=$KUBECONFIG:./kube/config
fi
export KUBECTL="true"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
if [ "$SECRET" = "true" ] ;
then export SECRET="true";
else kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" ; 
fi
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
export SECRET="true"
chmod 777 /home/user42/.docker
minikube start --driver=docker
bash