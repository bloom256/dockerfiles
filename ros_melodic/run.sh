docker run -it -d --name rosMelodic \
--gpus all \
--env="DISPLAY" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-e QT_X11_NO_MITSHM=1 \
-v /:/hostfs \
gitlab.navmii.com:4567/localization/ros_examples/rosgui:melodic