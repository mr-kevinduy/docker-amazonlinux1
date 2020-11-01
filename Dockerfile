FROM amazonlinux:2018.03

MAINTAINER KevinDuy <mr.kevinduy@gmail.com>

# Install packages
COPY ./install.sh /install/install.sh
COPY ./serve.sh /install/serve.sh

RUN chmod +x /install/*.sh

RUN /bin/bash /install/install.sh

WORKDIR /var/www/app

EXPOSE 80 443 9000
