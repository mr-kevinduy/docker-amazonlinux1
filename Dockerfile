FROM amazonlinux:2018.03

MAINTAINER KevinDuy <mr.kevinduy@gmail.com>

# Install packages
ADD _docker /usr/local/_docker

COPY ./install.sh /install/install.sh
COPY ./serve.sh /install/serve.sh

RUN chmod +x /install/*.sh

RUN /bin/bash /install/install.sh

WORKDIR /var/www/app
