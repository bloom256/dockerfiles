docker run --rm -it \
-v /:/hostfs \
-v /home/dan:/host_home \
--name conda-my \
--gpus all \
--privileged \
--network host --ipc host \
--env="DISPLAY" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-e QT_X11_NO_MITSHM=1 \
conda-my:latest /bin/bash
