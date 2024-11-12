docker run \
--name colmap \
 -it --rm \
-v /:/hostfs \
--gpus all \
--privileged \
--network host \
--env="DISPLAY" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-e QT_X11_NO_MITSHM=1 \
--user 1000:1000 \
colmap/colmap:latest 
