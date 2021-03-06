FROM ubuntu:14.04
MAINTAINER walkerwzy@gmail.com

RUN apt-get update
RUN apt-get upgrade -y --force-yes

### ppa
run apt-get install -y --force-yes software-properties-common
run add-apt-repository ppa:ondrej/php

RUN apt-get update
RUN apt-get upgrade -y --force-yes

RUN apt-get install -y --force-yes openssh-server apache2 supervisor
run apt-get install -y --force-yes python-pip aria2 git php7.0
run apt-get install -y --force-yes libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json
run mkdir -p /var/lock/apache2 /var/run/apache2
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor
run mkdir -p /var/www/aria2 /var/www/html/app
run mkdir -p /var/aria2
run touch /var/aria2/aria2.session
run echo "Listen 8081" >> /etc/apache2/ports.conf
run git clone https://github.com/ziahamza/webui-aria2.git /var/www/aria2

######## ssh start
# from https://docs.docker.com/engine/examples/running_ssh_service/

RUN echo 'root:walker' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

######## ssh end

# run pip install shadowsocks

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# copy shadowsocks.json /etc/shadowsocks.json
copy aria2_web.conf /etc/apache2/sites-enabled/aria2_web.conf
copy aria2.conf /var/aria2/aria2.conf

# 8080(shadowsocks)
EXPOSE 22 80 8081 6800
CMD ["/usr/bin/supervisord"]
