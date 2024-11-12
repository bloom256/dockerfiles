FROM nvidia/cudagl:10.0-devel-ubuntu18.04

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO melodic

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-melodic-desktop-full \
    ros-melodic-perception \
    build-essential \
    python-rosdep \
    python-rosinstall \
    python-rosinstall-generator \
    python-wstool \
    python-vcstools \
    python-pip \
    sudo \
    openssl \
    mc \
    wget \
    glmark2 \
    htop \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

RUN pip install torch==1.3.0+cu100 torchvision==0.4.1+cu100 -f https://download.pytorch.org/whl/torch_stable.html

RUN apt-get update && apt-get install -y \
    cmake \
    libgoogle-glog-dev \
    libgflags-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --branch 2.0.0 https://github.com/ceres-solver/ceres-solver.git /ceres \
    && mkdir /ceres/build && cd /ceres/build \
    && cmake .. && make -j12 && make install && make clean

RUN git clone --branch 3.4.3 https://github.com/opencv/opencv_contrib.git /opencv_contrib \
    && git clone --branch 3.4.3 https://github.com/opencv/opencv.git /opencv \
    && mkdir /opencv/build \
    && cd /opencv/build \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D OPENCV_GENERATE_PKGCONFIG=ON \
        -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
        .. \
    && make -j12 && make install && make clean

RUN wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - \
    && echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list \
    && apt-get update && apt-get install sublime-text

RUN pip install numpy matplotlib yacs cython matplotlib tqdm scikit-image
RUN pip install --upgrade numpy==1.16

RUN useradd -m -s /bin/bash -G sudo -p `openssl passwd -1 docker` docker
USER docker

RUN echo "source /opt/ros/melodic/setup.bash" >> /home/docker/.bashrc
RUN echo 'HISTCONTROL=ignoredups:erasedups' >> /home/docker/.bashrc
RUN echo 'shopt -s histappend' >> /home/docker/.bashrc
RUN echo 'PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"' >> /home/docker/.bashrc
RUN echo 'HISTSIZE=100000' >> /home/docker/.bashrc
RUN echo 'HISTFILESIZE=100000' >> /home/docker/.bashrc
RUN echo 'HISTTIMEFORMAT="%d/%m/%y %T "' >> /home/docker/.bashrc
