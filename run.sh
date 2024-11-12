#!/bin/bash

#Parameter: ./run.sh scenarios/00-opendrive-opensceneario <specific docker tag> <--visual, --verbose>

IMAGE_LOCAL="ostar:single_container"
IMAGE_DOCKER="bjoernbahndlr/ostar:2.0"
IMAGE_TAG=""
DISTRIBUTED_SIMULATION=false
DISTRIBUTED_SIMULATION_FLAG_FILE=distributed.txt
SCENARIO_PATH=""

if [[ -z "$1" || "$1" == --* ]]; then
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
fi

echo "Scenario path: $SCENARIO_PATH"

if [ -e $SCENARIO_PATH/$DISTRIBUTED_SIMULATION_FLAG_FILE ]; then
  DISTRIBUTED_SIMULATION=true
  echo "Run distributed simulation mode. Make sure to setup and start Carla beforehand."
  /bin/bash util/runDistributedSimulation.sh $@
  echo "OSTAR Simulation complete!"
  exit
fi

if [[ ! -z "$2" && ! "$2" == --* ]]; then
  IMAGE_TAG="$2"
elif docker image inspect $IMAGE_LOCAL >/dev/null 2>&1; then
  IMAGE_TAG=$IMAGE_LOCAL
else
  IMAGE_TAG=$IMAGE_DOCKER
fi
echo "Running with image $IMAGE_TAG"

/bin/bash util/runSingleContainer.sh $SCENARIO_PATH $IMAGE_TAG $@

echo "OSTAR Simulation complete!"
echo "Check the output directory to see results."


