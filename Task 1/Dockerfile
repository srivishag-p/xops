# Use a lightweight web server image
FROM nginx:alpine

# Remove default nginx page and copy our static site
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html/ 

# Expose port 80
EXPOSE 80


