$db_service=$args[0]
$db_service_ip=kubectl get pod --selector=app=$db_service -o=jsonpath='{.items[0].status.podIP}'

$headers = @{
    Authorization="Basic YWRtaW46YWRtaW4="
}
$response = Invoke-RestMethod -Uri "http://airflow-kubernetes/api/v1/connections/test" `
    -Method Post `
    -Headers $headers `
    -ContentType "application/json" `
    -Body "{`n`"connection_id`": `"$db_service`",`n`"conn_type`": `"postgres`",`n`"description`": `"`",`n`"host`": `"$db_service_ip`",`n`"login`": `"postgres`",`n`"schema`": `"postgres`",`n`"port`": 5432,`n`"password`": `"password`",`n`"extra`": `"`"`n}"

echo $response