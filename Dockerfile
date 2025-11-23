# Use official NGINX image
FROM nginx:latest

# Remove default NGINX static content
RUN rm -rf /usr/share/nginx/html/*

# Copy your website files into container
COPY ./index.html /usr/share/nginx/html/

# Expose port 80 for web traffic
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
