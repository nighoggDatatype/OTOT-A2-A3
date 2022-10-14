# Notes on commands used for A2:
Note that the setup script should be run using the command `bash k8s\a3_setup.sh` from the project root.

## Task A3.1.1: Deploy Metrics server
```
kubectl apply -f "k8s/manifests/k8s/metric-server.yaml"
```
### Verify A3.1.1
```
kubectl -n kube-system get deploy -w
```

## Task A3.1.2: Deploy Horizontal Pod Autoscaler
```
kubectl apply -f "k8s/manifests/k8s/backend-hpa.yaml"
```
### Verify A3.1.2

Load test:
```
bash test/a3p1_load_test.sh
```

View hpa and result of load test:
```
kubectl describe hpa
```
View raw pods:
```
kubectl get po
```

## Task A3.2: Deploy zone-aware Deployment
```
kubectl apply -f "k8s/manifests/k8s/A1-deployment-zone-aware.yaml"
```

To better see the zone aware nature of this deployment, kill the old deployment with this command:
```
kubectl delete deployment/backend
```

### Verify A2.2
```
kubectl get po -lapp=backend-zone-aware -owide --sort-by='.spec.nodeName'
```
View Zone Aware propery, to be used in conjunction with the first command:
```
kubectl get nodes -L topology.kubernetes.io/zone
```

## Teardown:
Minimal teardown of everything is as follows:
```
kind delete cluster --name kind-1
```