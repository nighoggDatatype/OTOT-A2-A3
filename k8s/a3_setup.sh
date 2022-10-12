# Create Cluster
kind create cluster --name kind-1 --config k8s/kind/cluster-config.yaml

# Deploy docker image
docker build -t nighogg-datatype-cs3244/otot-a1-nodeserver:latest ./app
kind load docker-image --name kind-1 nighogg-datatype-cs3244/otot-a1-nodeserver:latest
#TODO: Check if I need to add in an additonal constraint in the yaml file below
kubectl apply -f "k8s/manifests/k8s/A1-deployment-zone-aware.yaml" #TODO: Check if this override is proper

# Deploy Controller
kubectl apply -f "https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml"

# Wait for controller to be fully setup
until kubectl -n ingress-nginx get deploy | grep -m 1 "1/1"; do sleep 3 ; done

# Deploy Service
kubectl apply -f "k8s/manifests/k8s/service.yml"

# Deploy ingress
kubectl apply -f "k8s/manifests/k8s/ingress.yml"

# Metrics server
# Modified from https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
#  to include the arg `--kubelet-insecure-tls` at `deployment.spec.containers[].args[]`
# This means we don't need to edit a deployment live
kubectl apply -f "k8s/manifests/k8s/metric-server.yaml" 

# Wait for metrics-server to be fully setup
# TODO: Check whether this works later
until kubectl -n kube-system get deploy | grep -m 1 "1/1"; do sleep 3 ; done

# Horizontal Pod Autoscalar
kubectl apply -f "k8s/manifests/k8s/backend-hpa.yaml"