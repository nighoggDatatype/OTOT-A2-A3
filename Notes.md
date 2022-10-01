# Notes on commands used:
TODO: Use the notes here for final report

## Task A2.1: Deploy cluster
```
kind create cluster --name kind-1 --config k8s/kind/cluster-config.yaml
```
### Verify A2.1
```
docker ps
kubectl get nodes
kubectl cluster-info
```
## Task A2.2: Deploy your A1 Docker image as Deployment
```
docker build -t otot-a1-nodeserver:latest ./app
kind load docker-image --name kind-1 otot-a1-nodeserver:latest
kubectl apply -f k8s\manifests\A1_deployment.yml
```
### Verify A2.2
```
kubectl get deployment/backend --watch
```
//TODO: Figure out why this doesn't work. For some reason 'READY' status is stuck at 0/3

## Task A2.3 Deploy Ingres 
#TODO: finish this

#TODO: Actually test commands below
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

## Teardown:
```
kubectl delete deployment/backend
kind delete cluster --name kind-1
```