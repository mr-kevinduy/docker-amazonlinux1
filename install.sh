#!/bin/bash

cd ~

cat - << EOS >> ~/.bashrc
GREEN="\[$(tput setaf 2)\]"

YELLOW="\[$(tput setaf 3)\]"

RESET="\[$(tput sgr0)\]"

PS1="\n${GREEN}\u@\h ${YELLOW}\w${RESET}\n$ "
EOS

source ~/.bashrc

### Fixbug timeout yum
sed -i 's/timeout=5/timeout=300/g' /etc/yum.repos.d/amzn-*

### Fixbug ssl because proxy.
# Check proxy configuration allow ssl ?
# curl -x http://192.168.200.45:12080 https://www.google.com/
# curl -x http://192.168.200.45:12080 https://aws.amazon.com
# export http_proxy="http://192.168.200.45:12080"
# export https_proxy="http://192.168.200.45:12080"

# Set timezone to Japan
test -f /etc/sysconfig/clock && sed -i -e "s/ZONE=\"UTC\"/ZONE=\"Japan\"/g" /etc/sysconfig/clock || echo "ZONE=\"Japan\"" > /etc/sysconfig/clock

ln -sf /usr/share/zoneinfo/Japan /etc/localtime

# ============ Update and install packages
yum update -y && yum install -y \
sudo \
passwd \
acl \
git \
wget \
nano \
vim \
telnet \
htop \
zip \
unzip \
cronie \
golang \
python27-devel \
python27-pip \
python38 \
python38-devel \
python38-pip \
&& yum clean all

ln -s /usr/bin/pip-3.8 /usr/bin/pip3

pip install boto boto3 supervisor
pip3 install boto boto3

mkdir -p /etc/supervisor/conf.d
mkdir -p /var/log/supervisor

rm -rf /etc/supervisor/supervisord.conf
rm -rf /etc/init.d/supervisord
cp /usr/local/_docker/supervisor/supervisord.conf /etc/supervisor/
cp /usr/local/_docker/supervisor/init.d/supervisord /etc/init.d/
chmod a+x /etc/init.d/supervisord

chkconfig --add supervisord
chkconfig supervisord on

service supervisord start

# service supervisord status
# service supervisord start
# service supervisord restart
# ps -fe | grep supervisor

# ============ Install Incron
# AWS Linux 2018.03 with epel-release version 6 (el6)
wget http://rpmfind.net/linux/dag/redhat/el6/en/x86_64/dag/RPMS/incron-0.5.9-2.el6.rf.x86_64.rpm
rpm -Uvh incron*rpm
echo "root" >> /etc/incron.allow

# ============ Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf aws*

# ============ Install Apache2
# yum remove -y httpd
# yum remove -y httpd-tools
# yum install -y httpd24

# ============ Install PHP v7.3
yum install -y \
    php73 \
    php73-pdo \
    php73-mbstring \
    php73-xml \
    php73-json \
    php73-bcmath \
    php73-mysqlnd \

# ============ Install Composer latest version
# php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
# php composer-setup.php --version=2.1.0
# php -r "unlink('composer-setup.php');"
# mv composer.phar /usr/local/bin/composer

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer
