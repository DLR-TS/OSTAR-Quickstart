#!/bin/bash

#Parameter: ./run.sh scenarios/00-opendrive-openscenario <specific docker tag> <--visual, --verbose, --externalcarla>

IMAGE_LOCAL="ostar:single_container"
IMAGE_DOCKER="bjoernbahndlr/ostar:2.0"
IMAGE_TAG=""
DISTRIBUTED_SIMULATION=false
DISTRIBUTED_SIMULATION_FLAG_FILE=distributed.txt
SCENARIO_PATH=""
FLAGS=()

if [[ -z "$1" || "$1" == --* || ! -d "$1" ]]; then
  dirs=(scenarios/*/)
  echo "Choose a directory or add it as a runtime parameter:"
  select dir in "${dirs[@]}"; do
    if [ -n "$dir" ]; then
      SCENARIO_PATH=$dir
      break
    fi
  done
else
  SCENARIO_PATH=$1
  shift
fi

if [[ ! -z "$1" && ! "$1" == --* ]]; then
  IMAGE_TAG="$1"
  shift
elif docker image inspect $IMAGE_LOCAL >/dev/null 2>&1; then
  IMAGE_TAG=$IMAGE_LOCAL
else
  IMAGE_TAG=$IMAGE_DOCKER
fi

while [[ $# -gt 0 ]]; do
  FLAGS+=("$1")
  shift
done

echo "Scenario path: $SCENARIO_PATH"
echo "Running with image $IMAGE_TAG"
echo "With flags: ${FLAGS[*]}"

# Distributed simulation check
if [ -e $SCENARIO_PATH/$DISTRIBUTED_SIMULATION_FLAG_FILE ]; then
  DISTRIBUTED_SIMULATION=true
  echo "Run distributed simulation mode. Make sure to setup and start Carla beforehand."
  /bin/bash util/runDistributedSimulation.sh $@
  echo "OSTAR Simulation complete!"
  exit
fi

# Map file size check
if [ -e $SCENARIO_PATH/*tar.gz ]; then
  FILE_SIZE_MAP=$(stat -c%s $SCENARIO_PATH/*.tar.gz)
  if [ $FILE_SIZE_MAP -lt 1024 ]; then
    echo ".tar.gz files are interpreted as precompiled maps for Carla."
    echo "The input directory contains a $FILE_SIZE_MAP bytes small .tar.gz file. It may be a git-lfs reference to a map file."
    echo "Please install git-lfs before cloning/checkout or remove unnessesary .tar.gz files from the scenario directory."
    exit
  fi
fi

/bin/bash util/runSingleContainer.sh $SCENARIO_PATH $IMAGE_TAG ${FLAGS[@]}

echo "OSTAR Simulation complete!"
echo "Check the output directory to see results."

