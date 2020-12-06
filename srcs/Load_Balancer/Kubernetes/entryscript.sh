export KUBECONFIG=./.kube/config
minikube start --driver=docker
kubectl get po -A
# minikube dashboard
kubectl create deployment nginx --image=k8s.gcr.io/echoserver:1.4
kubectl expose deployment nginx --type=LoadBalancer --port=80 --port=443
# minikube tunnel
# kubectl get services hello-minikube

bash