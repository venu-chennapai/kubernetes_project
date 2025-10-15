FROM quay.io/centos/centos:stream8
LABEL maintainer="venuch8179@gmail.com"

RUN yum install -y httpd git
WORKDIR /var/www/html

RUN git clone https://github.com/themewagon/photogenic.git
RUN cp -rvf photogenic/* . && rm -rf photogenic

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
