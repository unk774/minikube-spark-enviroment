# minikube-spark-environment
minikube (version 1.32) spark environment set up for windows using hyper-v

## Prerequisites
installed minikube:

https://minikube.sigs.k8s.io/docs/start/

## Usage/Examples
Run powershell scripts as admin:

Enable cluster:
```
.\enable-cluster.ps1
```

Delete cluster:
```
.\delete-cluster.ps1
```

## Access spark
1. Get master node NAME and IP:

kubectl get pods -o wide

2. Enter master node

kubectl exec <spark-master-NAME> -it bash

3. bash with IP form spark-master pod

pyspark --conf spark.driver.bindAddress=<spark-master-IP> --conf spark.driver.host=<spark-master-IP>

```
words = 'the quick brown fox jumps over the lazy dog the quick brown fox jumps over the lazy dog'
sc = SparkContext.getOrCreate()
seq = words.split()
data = sc.parallelize(seq)
counts = data.map(lambda word: (word, 1)).reduceByKey(lambda a, b: a + b).collect()
dict(counts)
sc.stop()
quit()
```

## Move hyper-v storage

move hyper-v storage

1. Stop minikube - minikube stop
2. Use Hyper-V Manager.
3. Right-Click on VM and select option Move in the dropdown
4. on the Wizard screen you get "Choose Move Type" > Move the virtual machine's storage (already selected) > click Next

5. next screen give you option for moving. First option gives you VM to single location,
   second you can choose each set of files gose where (ie. disks go one folder, configs in other , snapshots third etc.) if you need to finetune the locations select option 2 , if all files go into single folder, option one

6. select where you want to move the files. this could be different folder or disk altogether.
7. click finish and wait until move is done.
8. Restart minikube - minikube start

## Troubleshooting

1. Error during .\enable-cluster.ps1:
   Error from server (InternalError): error when creating "./spark-kubernetes/minikube-ingress.yaml": Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io": failed to call webhook: Post "https://ingress-nginx-controller-admission.ingress-nginx.svc:443/networking/v1/ingresses?timeout=10s": dial tcp *.*.*.*:443: connect: connection refused

Solution - manual run:
kubectl apply -f ./spark-kubernetes/minikube-ingress.yaml

2. Could not open spark ui at - http://spark-kubernetes/
   Solution:

a) check C:\Windows\System32\drivers\etc\hosts

b) delete all entries for spark-kubernetes

b) run .\make-hosts-entry.ps1