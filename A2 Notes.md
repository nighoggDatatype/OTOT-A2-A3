# Notes on commands used for A2:
Note that the setup script should be run using the command `bash k8s\a2_setup.sh` from the project root.

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
kubectl apply -f k8s/manifests/k8s/A1_deployment.yml
```

//Note: Changes to A1 image was done minimally for resources that actually existed.

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
kubectl apply -f k8s/manifests/k8s/service.yml
```
*Verify*
```
kubectl get svc
```

### Ingress

```
kubectl apply -f k8s/manifests/k8s/ingress.yml
```
*Verify*
```
kubectl get ingress
```

//Note: Changes to ingress is based on https://github.com/kubernetes/ingress-nginx/blob/main/docs/examples/rewrite/README.md

## Teardown:
Teardown below is everything above in reverse order:
```
kubectl delete ingress.networking.k8s.io/backend
kubectl delete service/backend
kubectl delete all  --all -n ingress-nginx
kubectl delete deployment/backend
kind delete cluster --name kind-1
```
Minimal teardown of everything is as follows:
```
kind delete cluster --name kind-1
```