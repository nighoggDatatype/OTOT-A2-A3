# Notes on commands used:
TODO: Use the notes here for final report
TODO: In the verify steps, describe the 'ready' state

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
## Task A2.2: Deploy A1 Docker image as Deployment
```
docker build -t nighogg-datatype-cs3244/otot-a1-nodeserver:latest ./app
kind load docker-image --name kind-1 nighogg-datatype-cs3244/otot-a1-nodeserver:latest
kubectl apply -f k8s\manifests\A1_deployment.yml
```
### Verify A2.2
```
kubectl get deployment/backend --watch
kubectl get po -lapp=backend --watch
```

## Task A2.3 Deploy Ingres 
### Controller
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```
*Verify*:
```
kubectl -n ingress-nginx get deploy -w
```

### Service

```
kubectl apply -f k8s\manifests\service.yml
```
*Verify*
```
kubectl get svc
```

### Ingress

```
kubectl apply -f k8s\manifests\ingress.yml
```
*Verify*
```
kubectl get ingress
```
//TODO: Figure out how to get the animations working again.

## Teardown:
```
kubectl delete ingress.networking.k8s.io/backend
kubectl delete service/backend
kubectl delete all  --all -n ingress-nginx
kubectl delete deployment/backend
kind delete cluster --name kind-1
```