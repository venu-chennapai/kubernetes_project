FROM ubuntu:22.04
LABEL maintainer="venuch8179@gmail.com"

RUN apt-get update && apt-get install -y apache2 git

WORKDIR /var/www/html

RUN git clone https://github.com/themewagon/photogenic.git
RUN cp -rvf photogenic/* . && rm -rf photogenic

EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
