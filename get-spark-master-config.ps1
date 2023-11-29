$selector = "component=spark-master";
$sparkMasterIp = kubectl get pod --selector=$selector -o=jsonpath='{.items[0].status.podIP}';
$sparkMasterName = kubectl get pod --selector=$selector -o=jsonpath='{.items[0].metadata.name}';
echo "spark-master ip=$sparkMasterIp name=$sparkMasterName"