#!/bin/bash

# this is a manual rollout
# because i use smaller gcp nodes
# when your nodes are mostly starved for cpu/mem they tend not to
# behave properly as the required overhead just isn't there
# - that doesn't mean we can't get it done, tho
# eff it, we'll do it live!

image="gcr.io/heden-enterprises/web"
version="latest"

kube_deployment="heden-enterprises-web"
replicas="2"

if [ -f ./chart/values.yaml ] && grep -q "^replicaCount" ./chart/values.yaml; then
	replicas=$(grep "^replicaCount" ./chart/values.yaml | tr -d "[::space::]")
fi

build="./template/build.php --header=./template/header.php --footer=./template/footer.php"

exclude="-path assets -prune"
files=$(find . -type f -name "*.html" -o -name "*.php" $exclude)

for file in $files; do
	$build --content=$file > $file.tmp
	mv $file.tmp $file
done

docker build . -t $image:$version
docker push $image:$version

kubectl scale deployment/$kube_deployment --replicas=1
sleep 2

# wait until only 1 replica remains
while [ $(kubectl get pods -l hedenenterprises.io/app=$kube_deployment | grep Running | wc -l) -gt 1 ]; do
	echo "."
	sleep 1
done

last_one_standing=$(kubectl get pods -l hedenenterprises.io/app=$kube_deployment | grep Running | awk '{print $1}')

kubectl scale deployment/$kube_deployment --replicas=$replicas
sleep 2

kubectl delete pods/$last_one_standing
