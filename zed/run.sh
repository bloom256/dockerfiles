docker run \
--gpus all \
--env="DISPLAY" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-e QT_X11_NO_MITSHM=1 \
-v /home/dan/data:/data \
-v /home/dan/src:/src \
-it \
--rm \
--privileged \
--name zed \
--runtime nvidia \
zed_ros:latest
