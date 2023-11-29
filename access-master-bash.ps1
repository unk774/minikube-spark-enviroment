.\get-spark-master-config.ps1
$selector = "component=spark-master";
$sparkMasterName = kubectl get pod --selector=$selector -o=jsonpath='{.items[0].metadata.name}';
kubectl exec $sparkMasterName -it bash