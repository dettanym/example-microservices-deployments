#For online boutique
cd online-boutique && kubectl apply -f release/kubernetes-manifests.yaml

#For pitstop: from https://github.com/EdwinVW/pitstop/wiki/Run%20the%20application%20on%20Kubernetes
cd pitstop/src/k8s && ./start-all.sh --nomesh

#For sockshop: from https://microservices-demo.github.io/deployment/kubernetes-minikube.html
#Deploy the Sock Shop application on Minikube
cd sockshop && kubectl create -f deploy/kubernetes/manifests && \
#To start Opentracing run the following command after deploying the sock shop
kubectl apply -f deploy/kubernetes/manifests-jaeger && \
#Wait for all the Sock Shop services to start:
sleep 5 && kubectl get pods --namespace="sock-shop"

#For sitewhere
#From https://github.com/sitewhere/sitewhere-recipes/tree/master/charts#helm-charts-for-running-sitewhere-20
#helm install --name sitewhere --set persistence.storageClass=hostpath ./sitewhere
#This sitewhere-recipes repo is deprecated in favour of sitewhere-k8s
#https://github.com/sitewhere/sitewhere-k8s/tree/master/charts
#TODO: Check this repo out to setup sitewhere. 



