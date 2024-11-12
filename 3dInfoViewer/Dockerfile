# Use NVIDIA CUDA base image with OpenGL support on Ubuntu 20.04
FROM nvidia/cudagl:11.0-devel-ubuntu20.04

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub \
  && apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# setup environment
ENV TZ=UTC
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /cst_3dinfo

# Environment variables
ENV USD_INSTALL_PATH=/usr/local/USD
ENV QT_INSTALL_PATH=/usr/local/qt6
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get -y install \
        clang-format \
        gcc g++ make cmake \
        wget \
        git \
        libglew-dev \
        libxcursor-dev \
        libxinerama-dev \
        libxrandr-dev \
        python3.8-dev \
        python3-setuptools \
        python3-pip \
        libxrender1 libxrender-dev \
        libx11-xcb1 libx11-xcb-dev \
        libxkbcommon0 libxkbcommon-dev \
        libxkbcommon-x11-0 libxkbcommon-x11-dev \
        libfontconfig1 libfontconfig1-dev \
        libfreetype6 libfreetype6-dev \
        libxext6 libxext-dev \
        libx11-6 libx11-dev \
        libsm6 \
        libice6 \
        libxt-dev \
        libglib2.0-0 \
        libpthread-workqueue0 \
        libxfixes-dev \
        libxi-dev \
        libatspi2.0-dev \
        libegl-dev \
        'libxcb*-dev' \
        sudo \
        gnupg2 \
        tini \
        mc \
        htop \
        zip \
        libtbb-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies for USD
RUN pip3 install numpy PyOpenGL PySide2==5.14.1

# Download and build Qt's qtbase module
RUN cd /tmp && \
    git clone https://code.qt.io/qt/qtbase.git && \
    cd qtbase && \
    git checkout 6.2.4 && \
    mkdir build && cd build && \
    ../configure -incredibuild-xge -- \
                 -DCMAKE_INSTALL_PREFIX=$QT_INSTALL_PATH \
                 -DINSTALL_BINDIR=$QT_INSTALL_PATH/bin \
                 -DQT_BUILD_TESTS=OFF \
                 -DQT_BUILD_EXAMPLES=OFF \
                 -DQT_FEATURE_xcb_glx_plugin=ON \
                 -DFEATURE_xcb_xlib=ON \
                 -DFEATURE_xcb=ON \
                 -DFEATURE_reduce_relocations=OFF && \
    cmake --build . --parallel 10 && \
    cmake --install . && \
    rm -rf /tmp/qtbase

# Download and build Qt's qtsvg module
RUN cd /tmp && \
    git clone https://code.qt.io/qt/qtsvg.git && \
    cd qtsvg && \
    git checkout 6.2.4 && \
    mkdir build && cd build && \
    cmake -DCMAKE_PREFIX_PATH=$QT_INSTALL_PATH \
          -DQT_BUILD_TESTS=OFF \
          -DQT_BUILD_EXAMPLES=OFF \
          -DCMAKE_BUILD_TYPE=Release .. && \
    cmake --build . --config Release --parallel 10 && \
    cp lib/libQt6Svg*.so* $QT_INSTALL_PATH/lib && \
    cp plugins/imageformats/libqsvg*.so $QT_INSTALL_PATH/plugins/imageformats && \
    rm -rf /tmp/qtsvg


# Copy USD sources and build USD
RUN git clone --branch v24.05 --recursive https://github.com/PixarAnimationStudios/USD.git dependencies/USD && \
    python3 dependencies/USD/build_scripts/build_usd.py $USD_INSTALL_PATH \
    --jobs 10

ENV PATH=$USD_INSTALL_PATH/bin:$PATH
ENV PYTHONPATH=$USD_INSTALL_PATH/lib/python:$PYTHONPATH

# Clone and build 3D-Info
RUN git clone --recursive https://gitlab.com/3d-info/3d-info.git && \
    cd 3d-info && \
    git checkout v0.2.30 && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DUSD_INSTALL_PATH="$USD_INSTALL_PATH" \
          -DCMAKE_PREFIX_PATH="$QT_INSTALL_PATH" \
          .. && \
    cmake --build . --config Release --parallel 10


# Add docker user with passwordless sudo
RUN echo "docker     ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/docker_user_no_passwd && \
    useradd -m -s /bin/bash -G sudo -p $(openssl passwd -1 docker) docker

# Customize docker user's bash history settings
RUN echo 'HISTCONTROL=ignoredups:erasedups' >> /home/docker/.bashrc && \
    echo 'shopt -s histappend' >> /home/docker/.bashrc && \
    echo 'PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"' >> /home/docker/.bashrc && \
    echo 'HISTSIZE=100000' >> /home/docker/.bashrc && \
    echo 'HISTFILESIZE=100000' >> /home/docker/.bashrc && \
    echo 'HISTTIMEFORMAT="%d/%m/%y %T "' >> /home/docker/.bashrc

# Switch to docker user
USER docker

# Set up entrypoint and command for the application
ENTRYPOINT ["/cst_3dinfo/3d-info/build/cst_3dinfo"]
