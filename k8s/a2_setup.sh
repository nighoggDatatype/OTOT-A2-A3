#TODO: Fill this in with commands, and test this somehow. 
#      Either by having cmd directly interpret sh or installing stuff on the linux subsystem


# Create Cluster
kind create cluster --name kind-1 --config k8s/kind/cluster-config.yaml

# Deploy docker image
docker build -t nighogg-datatype-cs3244/otot-a1-nodeserver:latest ./app
kind load docker-image --name kind-1 nighogg-datatype-cs3244/otot-a1-nodeserver:latest
kubectl apply -f "k8s/manifests/k8s/A1_deployment.yml"

# Deploy Controller
kubectl apply -f "https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml"

# Wait for controller to be fully setup
until kubectl -n ingress-nginx get deploy | grep -m 1 "1/1"; do sleep 3 ; done

# Deploy Service
kubectl apply -f "k8s/manifests/k8s/service.yml"

# Deploy ingress
kubectl apply -f "k8s/manifests/k8s/ingress.yml"
