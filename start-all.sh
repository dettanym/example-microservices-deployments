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
helm repo add cetic https://cetic.github.io/helm-charts
helm repo update
#This command requires updating sitewhere-infrastructure/Charts.yaml with: 
#    version: 12.2.1 (postgres, line 37)
#    version: 17.8.0 (redis, line 49)
cd sitewhere-k8s/charts && helm dep update ./sitewhere-infrastructure/ #instead of sitewhere-infrastructure-min/ 
#TODO: This command throws a Chart.yaml file is missing error. 
# cd sitewhere-k8s/charts/sitewhere-infrastructure/ && \ 
#   helm install sitewhere-crds crds/. && \ #Drop --name flag 
#   helm install sitewhere-templates templates/. && \ 

# kubectl label namespace sitewhere istio-injection=enabled
