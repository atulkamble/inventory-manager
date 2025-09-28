Minikube workflow:

````markdown
# Minikube Deployment Guide

This guide walks through deploying the **Inventory Manager** app on Minikube with `NodePort`/`LoadBalancer`, enabling monitoring, and accessing logs.

---

## Step 1: Start Minikube Tunnel (Terminal Tab 1)

```bash
minikube tunnel
````

> Keeps running to allow LoadBalancer services to get an external IP.

---

## Step 2: Run Commands in Another Terminal (Terminal Tab 2)

### Get Minikube IP

```bash
minikube ip
```

---

## Step 3: Apply Deployment & Service

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

---

## Step 4: Verify Deployments, Pods, and Services

```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

---

## Step 5: Get Service URL

```bash
minikube service inventory-manager-service --url
```

---

## Step 6: Enable Metrics & Dashboard

```bash
minikube addons enable metrics-server
minikube dashboard
```

> Example dashboard URL:
>
> ```
> http://127.0.0.1:62691
> ```

---

## Step 7: Debugging Pods

### Get Pods by Label

```bash
kubectl get pods -l app=inventory
```

### Check Logs

```bash
kubectl logs deploy/inventory
```

---

✅ Now your **Inventory Manager app** should be running and accessible via the Minikube service URL or dashboard.

```

