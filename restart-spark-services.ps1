kubectl delete -f .\spark-kubernetes\minikube-ingress.yaml --ignore-not-found
kubectl delete -f .\spark-kubernetes\spark-worker-deployment.yaml --ignore-not-found
kubectl delete -f .\spark-kubernetes\spark-master-service.yaml --ignore-not-found
kubectl delete -f .\spark-kubernetes\spark-master-deployment.yaml --ignore-not-found

sleep 30

kubectl create -f ./spark-kubernetes/spark-master-deployment.yaml
kubectl create -f ./spark-kubernetes/spark-master-service.yaml
kubectl create -f ./spark-kubernetes/spark-worker-deployment.yaml
kubectl apply -f ./spark-kubernetes/minikube-ingress.yaml