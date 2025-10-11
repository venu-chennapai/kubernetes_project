FROM rockylinux:9
LABEL maintainer="venuch8179@gmail.com"

RUN yum install -y httpd \
    && echo "This is test server" > /var/www/html/index.html

EXPOSE 80
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]