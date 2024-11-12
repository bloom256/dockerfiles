FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN apt update -y \
&& apt install -y \
    htop \
    mc \
    sudo \
    tini \
    wget \
    openssl \
    git \
&& rm -rf /var/lib/apt/lists/*

# docker user
RUN echo "docker     ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/docker_user_no_passwd \
    && useradd -m -s /bin/bash -G sudo -p `openssl passwd -1 docker` docker
USER docker

# bashrc
RUN echo 'HISTCONTROL=ignoredups:erasedups' >> /home/docker/.bashrc \
    && echo 'shopt -s histappend' >> /home/docker/.bashrc \
    && echo 'PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"' >> /home/docker/.bashrc \
    && echo 'HISTSIZE=100000' >> /home/docker/.bashrc \
    && echo 'HISTFILESIZE=100000' >> /home/docker/.bashrc \
    && echo 'HISTTIMEFORMAT="%d/%m/%y %T "' >> /home/docker/.bashrc \
    && echo '. /opt/conda/etc/profile.d/conda.sh && conda activate dev' >> /home/docker/.bashrc

ENTRYPOINT ["tini", "-g", "--", "bash"]
