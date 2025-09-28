az group create --name aks --location centralindia

chmod +x aks.sh
./aks.sh
kubectl get nodes

cd eks
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get svc

// open browser 

http://20.99.214.163:5000/

kubectl set image deploy/inventory \
  inventory-container=docker.io/atuljkamble/inventory-manager:latest
kubectl patch deploy inventory -p '{"spec":{"template":{"spec":{"containers":[{"name":"inventory-container","imagePullPolicy":"Always"}]}}}}'
kubectl rollout status deploy/inventory


# Example image name (adjust if yours differs)
kubectl set image deploy/inventory inventory-container=atuljkamble/inventory-manager:latest --record
kubectl rollout status deploy/inventory

docker pull atuljkamble/inventory-manager

az group delete --name aks
