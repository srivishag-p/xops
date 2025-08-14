# XOps Terraform Web Server Challenge – Task 2

This project is part of the XOps hands-on challenge. It provisions an AWS EC2 instance using Terraform and hosts a simple Apache web server that serves:

> Hello from XOps!

---

## 🔧 Technologies Used

* Terraform
* AWS EC2, VPC, Subnets, Security Groups
* Amazon Linux 2
* Apache HTTP Server
* Git & GitHub

---

## 📁 Project Structure

```
Task 2/
├── main.tf
├── variables.tf
├── output.tf
├── README.md
└── screenshots/
    └── web-page.png
    └── execution.png
```

---

## 🚀 Deployment Instructions

### 1. Prerequisites

* AWS account (Free Tier)
* AWS CLI & Terraform CLI installed on your system
* An existing AWS Key Pair named xops-key (or update the key\_name in main.tf)

### 2. Configure AWS CLI

```bash
aws configure
```

Enter your Access Key, Secret Key, region (e.g., us-east-1), and preferred output format.

### 3. Initialize the Terraform Project

Open your terminal and run:

```bash
cd "Task 2"
terraform init
```

### 4. Apply Terraform Configuration

```bash
terraform apply -auto-approve
```

After successful deployment, Terraform will output your EC2 instance's public IP.

---

## 🌐 Access the Web Server

In your browser, open:

```
http://<EC2_PUBLIC_IP>
```

You should see:

```
Hello from XOps!
```

Take a screenshot and save it to:
Task 2/screenshots/web-page.png

---

## 🧹 Clean Up Resources

To avoid AWS charges, destroy all resources when you're done:

```bash
terraform destroy -auto-approve
```

Double-check your AWS console to make sure nothing was left behind.
