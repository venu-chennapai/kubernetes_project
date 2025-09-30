FROM centos:latest
MAINTAINER venuch8179@gmail.com
RUN yum install -y httpd \
    zip \
    unzip
ADD https://github.com/singhofen/photo-gallery-img-template/archive/refs/heads/master.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip master.zip
RUN cp -rvf master/* .
RUN rm -rf master master.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
