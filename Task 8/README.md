# ⚡ XOps Microchallenge #8 – ConfigMaps vs Secrets ⚡

This document provides a step-by-step walkthrough demonstrating and comparing **Kubernetes ConfigMaps** and **Secrets** using a local **kind cluster** setup on Windows.

---

## 🚀 ConfigMaps vs Secrets: A Comparison

| **Feature** | **ConfigMap** | **Secret** |
|--------------|---------------|-------------|
| **Use Case** | Stores non-sensitive configuration data in plain text. | Holds sensitive data such as passwords, API keys, and TLS certificates. |
| **Encoding** | Stored as plain text (readable to anyone with RBAC access). | Base64-encoded (for transport safety, not encryption). |
| **Security** | Values are visible by default using `kubectl describe`. | Values are hidden by default and require explicit decoding permissions. |
| **Best For** | Application settings, feature flags, or environment URLs. | Credentials, tokens, and secure certificates. |

---

## 🧩 Step-by-Step Implementation

### 1. Setup Cluster and Workspace

A new kind cluster named `xops` was created to provide a clean Kubernetes environment.  
A dedicated directory was also set up to store all Kubernetes manifests.

```bash
# Create a new kind cluster
kind create cluster --name xops

# Verify kubectl connectivity
kubectl cluster-info --context kind-xops

# Create workspace directory
mkdir k8s
````

---

### 2. Create and Apply a ConfigMap

A ConfigMap manifest file (`k8s/configmap.yaml`) was created to store non-sensitive app data such as environment settings and feature flags.

```bash
# Apply the ConfigMap
kubectl apply -f k8s/configmap.yaml

# Verify creation and view data
kubectl describe configmap app-config
```

---

### 3. Use ConfigMap as Environment Variables

A Pod was deployed to consume the ConfigMap and expose its data as environment variables inside the container.

```bash
# Apply Pod manifest
kubectl apply -f k8s/config-env-pod.yaml

# View environment variables in the running Pod
kubectl exec -it config-env-pod -- printenv
```
<img width="710" height="56" alt="Screenshot 2025-10-06 120445" src="https://github.com/user-attachments/assets/e9b29e97-4eab-4ecf-b36b-601e3ed850c8" />
<img width="676" height="405" alt="Screenshot 2025-10-06 120541" src="https://github.com/user-attachments/assets/a97838a0-c9a7-4fd8-81d5-60840a6c4cd6" />
---

### 4. Use ConfigMap as Mounted Files

To demonstrate another approach, a Pod was configured to mount the ConfigMap data as files inside the container’s filesystem.

```bash
# Apply Pod manifest
kubectl apply -f k8s/config-vol-pod.yaml

# Verify files in the /etc/config directory
kubectl exec -it config-vol-pod -- ls /etc/config

# View contents of the ConfigMap files
kubectl exec -it config-vol-pod -- cat /etc/config/APP_MODE
kubectl exec -it config-vol-pod -- cat /etc/config/FEATURE_X_ENABLED
```
<img width="732" height="175" alt="Screenshot 2025-10-06 120747" src="https://github.com/user-attachments/assets/4cad8dbc-45bc-41ae-8554-f694b9af1bfb" />
---

### 5. Create and Apply a Secret

A Secret was then created to securely store sensitive data.
Values were encoded in Base64 using PowerShell before being applied.
A separate Pod was used to consume the Secret and verify access.

```bash
# Apply Secret manifest
kubectl apply -f k8s/secret.yaml

# Deploy Pod that uses the Secret
kubectl apply -f k8s/secret-pod.yaml

# Verify decoded Secret values inside the Pod
kubectl exec -it secret-pod -- printenv | Select-String "DB"
```
<img width="766" height="166" alt="Screenshot 2025-10-06 121021" src="https://github.com/user-attachments/assets/0c6c50b9-6fb9-4878-84d8-daea3844567b" />
---

### 6. Clean Up the Environment

Once the demonstration was complete, the kind cluster was deleted to free up local resources.

```bash
# Delete the cluster
kind delete cluster --name xops
```

---

✅ **Summary:**

* **ConfigMaps** simplify configuration management for non-sensitive data.
* **Secrets** provide secure storage for confidential information.
  Together, they enable flexible and secure configuration management in Kubernetes.



