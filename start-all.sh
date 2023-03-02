#For online boutique
cd online-boutique && kubectl apply -f release/kubernetes-manifests.yaml 
cd ../ 

#For pitstop: from https://github.com/EdwinVW/pitstop/wiki/Run%20the%20application%20on%20Kubernetes
cd pitstop/src/k8s && ./start-all.sh --nomesh 
cd ../../../

#For sockshop: from https://microservices-demo.github.io/deployment/kubernetes-minikube.html
#Deploy the Sock Shop application on Minikube
cd sockshop && kubectl create -f deploy/kubernetes/manifests && \
#To start Opentracing run the following command after deploying the sock shop
kubectl apply -f deploy/kubernetes/manifests-jaeger && \
#Wait for all the Sock Shop services to start:
sleep 5 && kubectl get pods --namespace="sock-shop"
cd ../

# For sitewhere --- abandonware 
# From https://github.com/sitewhere/sitewhere-k8s/tree/master/charts/sitewhere#add-sitewhere-helm 
#helm repo add sitewhere-repo https://sitewhere.io/helm-charts
#helm repo update
#From https://github.com/sitewhere/sitewhere-k8s/tree/master/charts/sitewhere-infrastructure#installing-the-chart
#helm install sitewhere-infra-instance -n sitewhere-system --create-namespace sitewhere-repo/sitewhere-infrastructure 
#helm install sitewhere-instance -n sitewhere --create-namespace sitewhere-repo/sitewhere
#Both comamnds threw up errors as the CRDs have an older version (v1beta versus more recent v1)
#Error: INSTALLATION FAILED: failed to install CRD crds/040-Crd-kafka.yaml: resource mapping not found for name: 
#"kafkas.kafka.strimzi.io" namespace: "" from "": no matches for kind "CustomResourceDefinition" in version "apiextensions.k8s.io/v1beta1"
#ensure CRDs are installed first
#Error: INSTALLATION FAILED: unable to build kubernetes objects from release manifest: [resource mapping not found for name:
#"sitewhere-instance-cp-zookeeper-pdb" namespace: "" from "": no matches for kind "PodDisruptionBudget" in version "policy/v1beta1"
#The errors can be addressed by forking the sitewhere-k8s repo, making changes and pointing the submodule to our fork. 
#Changes can be made using grep (v1beta with v1) or using helm templates for a more context-aware replacement. 
