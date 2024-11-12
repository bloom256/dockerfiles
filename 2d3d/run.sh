docker run -it -d --name 2d3d_base \
--gpus all \
--env="DISPLAY" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-e QT_X11_NO_MITSHM=1 \
-v /home/dan/data:/data \
-v /home/dan/src:/src \
gitlab.navmii.com:4567/localization/monoafmlocalization/ubuntu_base:1.0.0
