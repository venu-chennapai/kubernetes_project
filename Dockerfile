FROM centos:latest
MAINTAINER venuch8179@gmail.com

# Install required packages
RUN yum install -y httpd git

# Set working directory
WORKDIR /var/www/html

# Clone the GitHub repository
RUN git clone https://github.com/themewagon/photogenic.git

# Copy website files to html root
RUN cp -rvf photogenic/* .

# Clean up unnecessary files
RUN rm -rf photogenic

# Start Apache in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose port 80
EXPOSE 80
