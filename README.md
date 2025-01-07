# Amazon Linux AMI 2018.03 (epel 6)

# 1. Using

`docker-compose.yml`

```yaml
services:
  app:
    image: kevinduy/amazonlinux1
    tty: true
    restart: always
    volumes:
      - ./:/app
    ports:
      - "80:80"
      - "433:443"
    environment:
      - http_proxy=${HTTP_PROXY}
      - https_proxy=${HTTPS_PROXY}
      - CHOKIDAR_USEPOLLING=true
      - AWS_DEFAULT_OUTPUT=json
      - AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
      - AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
      - AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
```

`Environment`

```sh
# Core env
HTTP_PROXY=
HTTPS_PROXY=

# AWS env
AWS_DEFAULT_OUTPUT=json
AWS_DEFAULT_REGION=ap-southeast-1
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
```

# 2. Main

- kevinduy/amazonlinux1:1.0 (kevinduy/amazonlinux1:latest)

### Build and push to repository docker hub

```sh
docker-compose up -d # OR: docker build -t kevinduy/amazonlinux1 .
docker image ls # OR: docker images

# Assign tag and push
# docker tag [OPTIONS] IMAGE[:TAG] [REGISTRYHOST/][USERNAME/]NAME[:TAG]
# docker push NAME[:TAG]
docker image tag kevinduy/amazonlinux1 kevinduy/amazonlinux1:1.0
# -> 2 images: latest and 1.0
docker login --username YOUR_ACCOUNT
docker push kevinduy/amazonlinux1:1.0
docker push kevinduy/amazonlinux1
```

# 3. Changelog

### [v1.0]
- OS:               amazonlinux:1 (amazonlinux:2018.03)
- Timezone:         Tokyo
- Packages:
  + wget 1.18
  + nano version 2.5.3
  + VIM - Vi IMproved 9.0
  + gzip 1.5 - gunzip (gzip) 1.5
  + zip 3.0
  + unzip 6.00
  + git version 2.38.4
  + golang go1.20.12 (go version)
  + python 2.7.18 - pip (using: python --version & pip --version)
  + python 3.8.5 - pip3 (using: python3 --version & pip3 --version)
  + php 7.3
  - composer latest
  - supervisor 4.2.5 (install by pip - python2.7) (supervisord -v)
