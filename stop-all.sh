#Online boutique
kubectl delete -f online-boutique/release/kubernetes-manifests.yaml
#Sockshop
kubectl delete -f sockshop/deploy/kubernetes/manifests
kubectl delete -f sockshop/deploy/kubernetes/manifests-jaeger
#Pitstop
cd pitstop/src/k8s && ./stop-all.sh
