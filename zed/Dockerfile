FROM stereolabs/zed:3.2-gl-devel-cuda10.0-ubuntu18.04

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

SHELL ["/bin/bash", "-c"]

RUN source /opt/ros/melodic/setup.bash && \
    mkdir -p /usr/local/zed/ros_ws/src && \
    cd /usr/local/zed/ros_ws/src && \
    git clone --branch v3.2.x https://github.com/stereolabs/zed-ros-wrapper.git && \
    cd .. && rosdep install --from-paths src --ignore-src -r -y && \
    catkin_make -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
        -DCUDA_CUDART_LIBRARY=/usr/local/cuda/lib64/stubs \
        -DCMAKE_CXX_FLAGS="-Wl,--allow-shlib-undefined"

RUN echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc
RUN echo 'HISTCONTROL=ignoredups:erasedups' >> /root/.bashrc
RUN echo 'shopt -s histappend' >> /root/.bashrc
RUN echo 'PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"' >> /root/.bashrc
RUN echo 'HISTSIZE=100000' >> /root/.bashrc
RUN echo 'HISTFILESIZE=100000' >> /root/.bashrc
RUN echo 'HISTTIMEFORMAT="%d/%m/%y %T "' >> /root/.bashrc
