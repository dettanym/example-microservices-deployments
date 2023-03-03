#!/usr/bin/env bash

set -e

function get_external_ip_port {
  kubectl get svc -n $1 $2 -o=jsonpath='{.status.loadBalancer.ingress[0].ip}:{.spec.ports[0].port}'
}

sleep 60

#TODO: Replace the sockshop with a while loop to check until the services are no longer pending
#Online boutique and pitstop use services of the type loadbalancer for their front-end
#we directly grab the ingress IP (which was allocated by metallb) from the pod's status
#We also grab the ingress service port from the spec
gio open http://$(get_external_ip_port default frontend-external)/
gio open http://$(get_external_ip_port pitstop webapp)/
#Sock-shop uses a nodeport service, so we grab the node's IP from Minikube
#We grab the ingress nodeport from the spec
MINIKUBE_IP=$(minikube ip)
SOCKSHOP_NODEPORT=$(kubectl get svc -n sock-shop front-end -o=jsonpath='{.spec.ports[0].nodePort}')
gio open http://${MINIKUBE_IP}:${SOCKSHOP_NODEPORT}

