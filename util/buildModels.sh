#!/bin/bash

cd "$(dirname "$0")"

#build model builder
docker build -f dockerfiles/DockerfileModelBuilder -t ostar:model_builder .

/bin/bash ../models/build_1-1-radar.sh
#/bin/bash ../models/build_1-2-lidar.sh #Wait for variant using only ASAM OSI, not SetLevel OSI.
/bin/bash ../models/build_1-3-generic.sh
/bin/bash ../models/build_1-4-camera.sh

