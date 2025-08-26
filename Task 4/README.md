---

# 🚀 DevOps Challenge – Terraform + Ansible Deployment

This project demonstrates **infrastructure provisioning with Terraform** and **application deployment with Ansible** on an AWS EC2 instance. Once deployed, it serves a **clean, static HTML page** automatically 🎉.

---

## 📂 Project Structure

```
Task4/
├── inventory          # Ansible inventory containing EC2 instance IP
├── site.yml           # Ansible playbook for configuring and deploying the app
├── index.html         # Web UI to be deployed on EC2
├── main.tf            # Terraform configuration to create EC2 instance & security groups
└── README.md          # Project documentation
```

---

## 🛠 Prerequisites

* Terraform (v1.5+ recommended)
* Ansible
* AWS Account with IAM user having **EC2FullAccess**
* SSH key pair (`terraform-key.pem`) for connecting to EC2

---

## 🚀 Deployment Steps

### 1️⃣ Initialize Terraform

```bash
terraform init
```

### 2️⃣ Provision Infrastructure

```bash
terraform apply -auto-approve
```

This will:

* Create an EC2 instance
* Create a security group allowing HTTP (80) and SSH (22)
* Output the public IP of the EC2 instance

### 3️⃣ Configure & Deploy with Ansible

```bash
ansible-playbook -i inventory site.yml
```

This playbook will:

* Install **Nginx**
* Copy `index.html` to `/usr/share/nginx/html/`
* Start the web server

### 4️⃣ Verify Deployment

Open your browser at:

```
http://<your-ec2-public-ip>
```

You should see your custom HTML page 🎨.

---

## 🔄 Updating the Website

If you make changes to `index.html`, simply rerun:

```bash
ansible-playbook -i inventory site.yml
```

> No need to rerun Terraform unless infrastructure changes are required.

---

## 🧹 Clean Up

Remove AWS resources when done:

```bash
terraform destroy -auto-approve
```

---

## 📸 Demo Screenshots

* Terraform EC2 Instance
* Ansible Playbook Execution
* Deployed Webpage Output

---

## ✅ Features

* Automated EC2 provisioning via Terraform
* Configuration management using Ansible
* Hosting a static website with Nginx
* Easy redeployment workflow

