$service = $args[0];$host_port = minikube service $service --url;$host_port = $host_port.replace('http://','').replace('https','');$clusterIp = kubectl get pod --selector=app=$service -o=jsonpath='{.items[0].status.podIP}'
echo "$service connection string:"
echo jdbc:postgresql://$host_port/postgres;
echo "inside cluster:"
echo jdbc:postgresql://$clusterIp`:5432/postgres;