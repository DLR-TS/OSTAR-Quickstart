#!/bin/bash
#Run demo of OSTAR in a single combined container

#create ne output directory if neccessary
mkdir -p output

output_abs_path=$(realpath output)

#Delete old containers if present
if docker ps -a | grep "ostar-single-container"; then
	docker rm ostar-single-container || true
fi

docker run --privileged --net=host --gpus all --name ostar-single-container -e DISPLAY=$DISPLAY -it --mount type=bind,source="$output_abs_path",target=/home/carla/output ostar:single_container

echo "Done. See simulation output in output directory"

