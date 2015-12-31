FROM ubuntu:13.04
MAINTAINER walkerwzy@gmail.com
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y --force-yes  perl-base=5.14.2-6ubuntu2
RUN apt-get install -y apache2.2-common
RUN apt-get install -y openssh-server apache2 supervisor
run apt-get install -y python-pip
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

run pip install shadowsocks

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
copy shadowsocks.json /etc/shadowsocks.json

EXPOSE 22 80 8080 1080
CMD ["/usr/bin/supervisord"]