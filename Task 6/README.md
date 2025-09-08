# 🚀 XOps Task-6 – CI/CD + Kubernetes with GitHub Actions & Argo CD

## 📌 Overview

This project demonstrates a complete **GitOps workflow** where a simple application is:

1. Dockerized and pushed to Docker Hub using **GitHub Actions**
2. Deployed to a Kubernetes cluster via **Argo CD**
3. Automatically updated on new code pushes

---

## 🎯 Objective

* Build & push Docker images to Docker Hub
* Manage Kubernetes manifests in a separate repo
* Use **Argo CD** for automated syncing and deployment

---

## 📂 Repository Structure

### App Repo (`xops-app-repo`)

```
app-repo/
├── Dockerfile
├── index.html
└── .github/workflows/cicd.yaml
```

### Infra Repo (`Task-6`)

```
Task 6/
└── k8n/
    ├── deployment.yaml
    ├── service.yaml
└── app.yaml
└── README.md
```

---

## ⚡ CI/CD Flow

1. Developer pushes code → GitHub Actions triggers.
2. Action builds Docker image → pushes to Docker Hub.
3. Workflow updates `deployment.yaml` in **infra-repo** with new image tag.
4. Argo CD detects changes → syncs → deploys new app version to cluster.

---

## 🔧 Setup Instructions

### 1. App Repo

* Add Dockerfile + app code (e.g., `index.html`)
* Configure GitHub Secrets:

  * `DOCKER_USERNAME`
  * `DOCKER_PASSWORD`
  * `TOKEN`

### 2. Infra Repo

* Store Kubernetes manifests under `k8n/`
* Example `deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: xops-app
  labels:
    app: xops-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: xops-app
  template:
    metadata:
      labels:
        app: xops-app
    spec:
      containers:
      - name: xops-app
        image: DOCKERUSERNAME/xops-app:latest
        ports:
        - containerPort: 80

```

* Example `service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: xops-app-service
spec:
  type: NodePort
  selector:
    app: xops-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30080
```

---

### 3. Install Argo CD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

* Login with `admin` / initial password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
```

---

### 4. Connect Argo CD to Infra Repo

```bash
argocd app create xops-app \
  --repo https://github.com/srivishag-p/xops/Task%106.git \
  --path k8s \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default \
  --sync-policy automated
```

---

## ✅ Verification

* Check pods & service:

```bash
kubectl get pods
kubectl get svc xops-app-service
```

* Access app:

```bash
curl http://localhost:30080
```

---

## 📝 Submission Checklist

* ✅ GitHub Actions pipeline run successful
* ✅ Argo CD sync successful
* ✅ App accessible in Kubernetes

## Screenshots
<img width="1861" height="962" alt="Screenshot 2025-09-05 150911" src="https://github.com/user-attachments/assets/0e7c3459-5848-436e-b9ea-8fccc14b9ee1" />
<img width="1919" height="864" alt="Screenshot 2025-09-05 150925" src="https://github.com/user-attachments/assets/ac9285f7-5769-48de-8606-429a7fce32ec" />

