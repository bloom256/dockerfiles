docker run -it --rm \
--name 3d_info \
--gpus all \
--privileged \
--env="DISPLAY" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--network host --ipc host \
-e QT_X11_NO_MITSHM=1 \
-v /:/hostfs \
3d_info:dev "/hostfs/$1"