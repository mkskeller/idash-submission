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
ADD src/static/replicated-ring-party.x src/
RUN rm -R ./src/.git ./src/Player-Data ./src/Programs/Bytecode ./src/Programs/Schedules

ADD *train.txt ./
ADD *.sh *.py *.md ./
