$clusterIP = minikube ip
$fileBkp = "C:\Windows\System32\drivers\etc\hosts.spark.bkp"
$file = "C:\Windows\System32\drivers\etc\hosts"
$hostfile = Get-Content $file
Set-Content -Path $fileBkp -Value $hostfile -Force
$hostfile += "`n" + $clusterIP + " spark-kubernetes"
Set-Content -Path $file -Value $hostfile -Force