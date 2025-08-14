# 🚀 XOps Task 1 – Static Website in Docker

## 📄 Overview

This project features a simple, styled static website built using **HTML and CSS**. The webpage is hosted using an **Nginx Docker container** based on a lightweight Alpine Linux image.

<img width="1829" height="858" alt="Screenshot 2025-08-05 121306" src="https://github.com/user-attachments/assets/be398e09-5606-412a-9d5d-1a5ca2f6fbc2" />

---

## 📁 Project Files

* **`index.html`**
  The main HTML file that displays the XOps welcome page.

* **`styles.css`**
  Provides custom styling for the HTML page.

* **`Dockerfile`**
  Contains the Docker instructions to build and serve the static site using Nginx.

---

## ⚙️ Dockerfile Breakdown

```dockerfile
# Use a lightweight web server image
FROM nginx:alpine

# Remove default nginx page and copy our static site
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html/ 

# Expose port 80
EXPOSE 80
```

### 🔍 Explanation:

* `nginx:alpine` is a minimal Nginx image with low overhead.
* The default Nginx web content is removed to avoid conflicts.
* Your local project files (`index.html`, `styles.css`, etc.) are copied into Nginx’s web root.
* Port 80 is exposed for web access.

---

## 🛠️ How to Build and Run

### 1️⃣ Build the Docker Image

In the terminal, navigate to your project directory and run:

```bash
docker build -t xops-task-1 .
```

### 2️⃣ Run the Docker Container

After building, start the container:

```bash
docker run -p 8080:80 xops-task-1
```

### 3️⃣ Open in Browser

Go to:

```
http://localhost:8080
```

You should see your XOps welcome page running inside a Docker container!

