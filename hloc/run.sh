docker run -it -d --name hloc \
--gpus all \
--env="DISPLAY" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-e QT_X11_NO_MITSHM=1 \
-v /home/dan/data:/data \
-v /home/dan/src:/src \
-p 7777:7777 \
hloc
