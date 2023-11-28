$service = $args[0];$host_port = minikube service $service --url;$host_port = $host_port.replace('http://','').replace('https','');
echo "postgres-dev connection string:"
echo jdbc:postgresql://$host_port/postgres;