```markdown
# 🚀 Flask CI/CD Demo

A simple **Flask** web application to demonstrate running locally and deploying via **GitHub Actions** to **Amazon Linux 2 / Ubuntu EC2**.

---

## 📌 Features
- Simple Flask web server
- Health check endpoint (`/api/health`)
- Ready for CI/CD using GitHub Actions
- Full step-by-step runbook for deploying to EC2

---

## 📂 Project Structure
.
├── templates
├── app.py           # Main Flask app
├── requirements.txt # Dependencies
└── README.md        # Documentation

````

---

## ⚡ Running Locally

### Clone the repo
```bash
git clone https://github.com/<your-username>/<your-repo>.git
cd <your-repo>
````

## 📡 API Endpoints

| Endpoint      | Method | Description             |
| ------------- | ------ | ----------------------- |
| `/`           | GET    | Welcome message         |
| `/api/health` | GET    | Health check (status ✅) |

---

# 🛠️ CI/CD Pipeline to EC2

This project comes with a **real CI/CD pipeline** that auto-deploys to an EC2 instance whenever you push to `main`.

---

## 🧠 What this is (in plain English)

* **CI/CD** = Continuous Integration / Continuous Delivery.

  * **CI**: every push runs automated steps (build/test).
  * **CD**: when you merge to `main`, your app **auto-deploys** somewhere (here: EC2).

* **Your pipeline**: GitHub Actions runner → SSH into EC2 → copy new code → restart web server → live site updates.

---

## 🏗️ Architecture

You → `git push` → **GitHub Actions** → (SSH) → **EC2 (NGINX / Gunicorn)** → serves your site on **http\://EC2\_PUBLIC\_IP/**

---

## ✅ Step-by-step Guide

### 1. Create & prepare EC2 instance

* Launch **Ubuntu 22.04** (or Amazon Linux 2).
* Open ports **22 (SSH)**, **80 (HTTP)**, and optionally **5000 (Flask)**.
* Install NGINX or Python (depending on app type).
* Verify you can SSH in.

### 2. Add GitHub Secrets

In your repo → **Settings → Secrets and variables → Actions**:

* `EC2_PUBLIC_IP`
* `SSH_USERNAME` (usually `ubuntu` or `ec2-user`)
* `SSH_PRIVATE_KEY` (contents of your `.pem`)

### 3. GitHub Actions Workflow

Create `.github/workflows/deploy.yml`:

```yaml
name: 🚀 Deploy Task3 App to EC2
 
on:
  push:
    branches:
      - main
 
jobs:
  deploy:
    runs-on: ubuntu-latest
 
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3
 
      - name: Setup SSH
        run: |
          mkdir -p ~/.ssh
          echo "${{ secrets.SSH_PRIVATE_KEY }}" > ~/.ssh/deploy_key.pem
          chmod 600 ~/.ssh/deploy_key.pem
          ssh-keyscan -H ${{ secrets.EC2_PUBLIC_IP }} >> ~/.ssh/known_hosts
 
      - name: Deploy Task3 Code to EC2
        run: |
          rsync -avz -e "ssh -i ~/.ssh/deploy_key.pem" ./Task\ 3/ \
            ${{ secrets.SSH_USERNAME }}@${{ secrets.EC2_PUBLIC_IP }}:/home/${{ secrets.SSH_USERNAME }}/app/
 
      - name: Restart App on EC2
        run: |
          ssh -i ~/.ssh/deploy_key.pem ${{ secrets.SSH_USERNAME }}@${{ secrets.EC2_PUBLIC_IP }} << 'EOF'
            # Install Python and pip if not already
            sudo yum install -y python3 python3-pip
 
            # Kill old process if running
            pkill -f app.py || true
 
            # Navigate to app dir
            cd ~/app
 
            # Install requirements
            if [ -f requirements.txt ]; then
              pip3 install -r requirements.txt
            else
              pip3 install flask
            fi
 
            # Run Flask on port 5000 (non-root safe)
            nohup python3 app.py > app.log 2>&1 &
          EOF
```

---

## 🚨 Common Pitfalls

* **Permission denied (publickey)** → Check `SSH_USERNAME` + matching `.pem` file.
* **requirements.txt not found** → Ensure correct relative path.
* **Port not accessible** → Add port 5000/80 to EC2 Security Group.
* **YAML errors** → Indentation must be 2 spaces.

---

## 🧹 Cleanup

* Terminate EC2 when done (avoid charges).
* Remove GitHub Secrets if repo is public.

---

## 📜 License

MIT License. Free to use and modify.

---

✨ Made with Flask & ❤️

```

---

