#!/bin/bash

docker run -d --rm -it \
--name dotnet_6_0_dev \
-v /:/hostfs \
--network=host \
dotnet_6_0:dev
