docker run -u 1000:1000 --rm -v /home/dan/data:/data -v /home/dan/src:/src \
gitlab.navmii.com:4567/voxelmaps/merger/merger:0.1.1 \
--frames-folder /data/verizon/2019_11_29-01-11-36/orig/frames \
--out-folder /data/verizon/2019_11_29-01-11-36/orig/MVs \
\ #--slam-poses-json \
--thread-count 6 \
--voxel-side-size 0.04 \
--megavoxel-side-size 2047 \
--max-lidar-ray-length 99 \
--min-lidar-ray-length 2 \
--use-median-filter-for-types 0 \
--range-filter-beam-divergence=0.006 \
--range-filter-max-distance=15 \
--median-filter-only-black-points 1 \
--writeECEF 0 \
--type-distance-filter-config /src/voxelmaps.networkweights/SemanticSegmenatation/BiSeNet_dizf_ResNet50_1216x1024_3x3_3x3_3x3/typeDistanceFilterConf.csv \
--logfile /data/merger.log
