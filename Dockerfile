FROM ubuntu:16.04
MAINTAINER Javier Aranda <javier.aranda.varo@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV GIT_SSL_NO_VERIFY true
ENV SHELL /bin/bash

# use spanish as language
RUN locale-gen es_ES.UTF-8
ENV LANG es_ES.UTF-8
ENV LANGUAGE es_ES:es
ENV LC_ALL es_ES.UTF-8

# packages
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git vim wget ca-certificates realpath && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# direnv
RUN cd /usr/local/bin && \
    wget -q -O direnv https://github.com/zimbatm/direnv/releases/download/v2.9.0/direnv.linux-amd64 && \
    chmod u+x direnv

# dotvim
RUN cd /root && git clone https://github.com/javierav/dotvim.git .vim && \
    cd .vim && git submodule update --init

# dotfiles
RUN cd /root && git clone https://github.com/javierav/dotfiles.git .dotfiles && \
    cd .dotfiles && ./install.sh -f

# default command
CMD /bin/bash -l
