FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y install python
RUN apt-get -y install openssh-client openssh-server
RUN apt-get -y install rsync

WORKDIR /root
RUN echo | ssh-keygen
RUN cp .ssh/id_rsa.pub .ssh/authorized_keys
RUN echo StrictHostKeyChecking no >> .ssh/config
ADD .bashrc .

WORKDIR /usr/mp-spdz
ADD src/ src/

ADD *train.txt ./
ADD *.sh *.py *.md ./

RUN echo Port 2222 >> /etc/ssh/sshd_config
