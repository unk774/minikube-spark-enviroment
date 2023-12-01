#minikube version: v1.32.0
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

minikube start --driver=hyperv

kubectl apply -f ./postgres/postgres-dev.yaml
kubectl apply -f ./postgres/postgres-test.yaml

minikube docker-env
minikube -p minikube docker-env --shell powershell | Invoke-Expression

docker build -f docker/Dockerfile -t spark-hadoop:3.2.0 ./docker

kubectl create -f ./spark-kubernetes/spark-master-deployment.yaml
kubectl create -f ./spark-kubernetes/spark-master-service.yaml
kubectl create -f ./spark-kubernetes/spark-worker-deployment.yaml

minikube addons enable ingress

Start-Sleep -Seconds 30

kubectl apply -f ./spark-kubernetes/minikube-ingress.yaml

helm repo add apache-airflow https://airflow.apache.org
helm upgrade -f .\airflow\override.yaml --install airflow apache-airflow/airflow `
      --set ingress.web.enabled=true `
      --set ingress.web.host=airflow-kubernetes `
      --namespace default

echo "cluster ip:"; minikube ip;

.\get-jdbc-string.ps1 postgres-dev
.\get-jdbc-string.ps1 postgres-test

.\make-hosts-entry.ps1

.\airflow\make-connection.ps1 postgres-dev
.\airflow\test-connection.ps1 postgres-dev
.\airflow\make-connection.ps1 postgres-test
.\airflow\test-connection.ps1 postgres-test

echo "airflow webserver - http://airflow-kubernetes/"
echo "spark ui - http://spark-kubernetes/"        
.\get-spark-master-config.ps1