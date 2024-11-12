docker run \
--gpus all \
--rm -it \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY -e NVIDIA_DRIVER_CAPABILITIES=all \
-v /:/hostfs \
--entrypoint /usr/local/bin/CloudCompare \
tswetnam/cloudcompare:latest
