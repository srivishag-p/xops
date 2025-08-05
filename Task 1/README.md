# XOps-Task-1 Website
 
## Overview
 
This project contains a simple, designed HTML page that displays:
 
<img width="1236" height="640" alt="image" src="https://github.com/user-attachments/assets/5789a3ed-534c-458a-bc30-7138cf8d3715" />
 
 
---
 
## Files
 
- **index.html**  
  Contains the HTML code and CSS styles for the XOps welcome page.
 
- **DockerFile**  
  Defines instructions to build a Docker image using [Nginx](https://nginx.org/) on Alpine Linux to serve the static HTML page.
 
---
 
## How the DockerFile Works
 
```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
EXPOSE 80
```
 
---
## To Build and Run
 
1. **Build the Docker Image**  
   Open a terminal in the project directory and run:
   ```bash
   docker build -t xops-task-1 .
   ```
2. **Run the Docker Container**  
   After the image is built, run the container with:
   ```bash
   docker run -p 8080:80 xops-task-1
   ```
   ---
3. **Access the Page**  
   Open a web browser and navigate to `http://localhost:8080` to view the XOps welcome page.
