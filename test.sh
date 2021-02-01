minikube start --driver=docker #--base-image="gcr.io/k8s-minikube/kicbase:v0.0.15-snapshot4@sha256:ef1f485b5a1cfa4c989bc05e153f0a8525968ec999e242efff871cbb31649c16"
eval $(minikube docker-env)
minikube addons enable dashboard
minikube addons enable metrics-server
minikube addons enable metallb
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
#if [ -e $metallb ] ;
#else
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
#fi
kubectl apply -f config.yaml
