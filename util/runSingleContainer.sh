#!/bin/bash

OUTPUT_DATE=$(date +"%Y-%m-%d %H:%M:%S")
CONTAINER_NAME="ostar-single-container"
SCENARIO_PATH=$1
SCENARIO_NAME=$(basename $SCENARIO_PATH)
IMAGE_TAG=$2

rm -r input
mkdir input
input_abs_path=$(realpath input)

echo "Copy FMU models into input directory."
cp models/fmu/*.fmu input/
echo "Copy scenario files into input directory."
cp $SCENARIO_PATH/* input/

echo "Create output directory output/$SCENARIO_NAME-$OUTPUT_DATE"
mkdir -p "output/$SCENARIO_NAME-$OUTPUT_DATE"
output_abs_path=$(realpath "output/$SCENARIO_NAME-$OUTPUT_DATE")

#Delete old containers if present
if docker ps -a | grep $CONTAINER_NAME ; then
  docker rm $CONTAINER_NAME || true
fi

docker run --privileged --net=host --gpus all --name $CONTAINER_NAME -e DISPLAY=$DISPLAY -it --mount type=bind,source="$input_abs_path",target=/home/carla/input --mount type=bind,source="$output_abs_path",target=/home/carla/output $IMAGE_TAG $@

echo "Done. See simulation output in output directory"

