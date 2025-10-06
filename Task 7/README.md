# XOps Microchallenge #7 — Kubernetes Secrets

## Included files
- `k8s-secret.yaml` — Secret manifest  
- `secret-env-pod.yaml` — Pod with secret as env vars  
- `secret-vol-pod.yaml` — Pod with secret mounted as files  
- `README.md`  

---

# Environment Variables vs Mounted Files in Kubernetes Secrets

## Environment Variables

- Best for small, simple values (like DB usernames or passwords).  
- Easy for applications to consume.  
- Risky because values can appear in logs, crash dumps, or debugging sessions.  
- Secret values are only loaded when the pod starts — updating the Secret does **not** automatically update running pods.

## Mounted Files

- Secrets are written as files inside the container (e.g., `/etc/secrets/DB_USER`).  
- Useful for certificates, keys, or larger configuration values.  
- Kubernetes can update the files automatically if the Secret changes (**no pod restart needed**).  
- Slightly more work for the app, since it must read from files instead of env vars.

## 👉 Rule of thumb
Use environment variables for simple app configs, and mounted files for sensitive or larger data like TLS certs/keys.

---

# 🛠️ Step-by-Step Execution

### 1. Apply the Secret
```bash
kubectl apply -f k8s/k8s-secret.yaml
kubectl get secret db-credentials
````

<img width="700" height="168" alt="Screenshot 2025-09-17 184406" src="https://github.com/user-attachments/assets/d3ae7547-0452-4cdd-b67f-711ac91a4893" />

---

### 2. Apply env pod and check env vars

```bash
kubectl apply -f k8s/secret-env-pod.yaml
kubectl wait --for=condition=Ready pod/secret-env-pod --timeout=60s
kubectl exec -it secret-env-pod -- env | grep DB_
```

<img width="1392" height="190" alt="Screenshot 2025-10-06 110834" src="https://github.com/user-attachments/assets/a8489d4d-f1d7-48c0-abb9-c8a269ef527b" />

---

### 3. Apply volume pod and check files

```bash
kubectl apply -f k8s/secret-vol-pod.yaml
kubectl wait --for=condition=Ready pod/secret-vol-pod --timeout=60s
kubectl exec -it secret-vol-pod -- ls /etc/secrets
kubectl exec -it secret-vol-pod -- cat /etc/secrets/DB_USER
kubectl exec -it secret-vol-pod -- cat /etc/secrets/DB_PASSWORD
```

<img width="1019" height="275" alt="Screenshot 2025-10-06 111110" src="https://github.com/user-attachments/assets/89fad387-adc0-498d-9ce3-5aab5e5eadb7" />

