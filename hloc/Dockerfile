FROM nvidia/cudagl:11.0-devel-ubuntu20.04

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# dependencies and usefull packages
RUN apt update -y \
&& apt-get install -q -y \
    apt-transport-https \
    autoconf \
    binutils-dev \
    build-essential \
    cmake \
    gdb \
    git-gui \
    gitk \
    glmark2 \
    gnupg2 \
    htop \
    mc \
    pkg-config \
    software-properties-common \
    sudo \
    wget \
&& rm -rf /var/lib/apt/lists/*

# setup user
RUN echo "docker     ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/docker_user_no_passwd \
    && useradd -m -s /bin/bash -G sudo -p `openssl passwd -1 docker` docker
USER docker

RUN echo 'HISTCONTROL=ignoredups:erasedups' >> /home/docker/.bashrc \
    && echo 'shopt -s histappend' >> /home/docker/.bashrc \
    && echo 'PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"' >> /home/docker/.bashrc \
    && echo 'HISTSIZE=100000' >> /home/docker/.bashrc \
    && echo 'HISTFILESIZE=100000' >> /home/docker/.bashrc \
    && echo 'HISTTIMEFORMAT="%d/%m/%y %T "' >> /home/docker/.bashrc
