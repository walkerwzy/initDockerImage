FROM ubuntu:14.04
MAINTAINER walkerwzy@gmail.com

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

#RUN apt-get install -y --force-yes  perl-base=5.14.2-6ubuntu2

RUN apt-get install -y apache2.2-common
RUN apt-get install -y openssh-server apache2 supervisor
run apt-get install -y python-pip
run mkdir -p /var/lock/apache2 /var/run/apache2
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

# ssh start
# from https://docs.docker.com/engine/examples/running_ssh_service/

RUN echo 'root:walker' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# ssh end

run pip install shadowsocks

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
copy shadowsocks.json /etc/shadowsocks.json

EXPOSE 22 80 8080 1080
CMD ["/usr/bin/supervisord"]