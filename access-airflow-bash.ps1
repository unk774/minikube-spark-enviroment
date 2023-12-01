$selector = "component=webserver,tier=airflow";
$service = kubectl get pod --selector=$selector -o=jsonpath='{.items[0].metadata.name}';
kubectl exec $service -it bash