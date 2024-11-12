FROM nvidia/cudagl:11.0-devel-ubuntu20.04

# fix nvidia keys
RUN apt-key del 7fa2af80 \
  && apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt-get install -y -qq --no-install-recommends \
    coreutils \
    git \
    git-gui \
    gitk \
    glmark2 \
    htop \
    libgl1-mesa-dev \
    mc \
    openssl \
    sudo \
    tini \
    wget \
    zip \
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
  && echo 'HISTTIMEFORMAT="%d/%m/%y %T "' >> /home/docker/.bashrc

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py38_23.3.1-0-Linux-x86_64.sh -O /home/docker/miniconda.sh \
  && bash /home/docker/miniconda.sh -b -p /home/docker/miniconda

ENV PATH="/home/docker/miniconda/bin:${PATH}"

RUN conda create -n "dan" python=3.8

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "dan", "/bin/bash", "-c"]

RUN conda config --add channels conda-forge \
  && conda config --add channels open3d-admin \
  && conda config --set channel_priority strict

RUN conda install -y -q jupyter ipympl ipyvolume \
  imutils \
  numpy \
  pandas \
  opencv \
  scipy \
  plumbum \
  pytransform3d \
  icecream \
  ruamel.yaml \
  matplotlib \
  plotly \
  open3d \
  proj \
  pyproj

RUN conda run projsync --all

ENTRYPOINT ["tini", "-g", "--", "conda", "run", "--no-capture-output", "-n", "dan"]
CMD ["jupyter", "notebook", "--notebook-dir=/host_home/src/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
