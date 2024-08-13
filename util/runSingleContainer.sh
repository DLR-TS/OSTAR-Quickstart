#!/bin/bash
rm -r input
mkdir input
input_abs_path=$(realpath input)

echo "Copy FMU models into input directory!"
cp models/*.fmu input/

SCENARIO_BY_PARAMETER=false
SCENARIO_NUMBER=-1
ALL_PARAMETERS="$@"
IMAGE_NAME=""

while [[ "$#" -gt 0 ]]; do
  if [[ $1 =~ [0-7]$ ]]; then
    SCENARIO_NUMBER=$1
    echo "Automatic scenario selection: $SCENARIO_NUMBER"
  fi
  if [[ $1 = SingleContainerLocal ]];  then
    IMAGE_NAME="ostar:single_container"
  fi
  if [[ $1 = SingleContainerDockerhub ]];  then
    IMAGE_NAME="bjoernbahndlr/ostar:1.1"
  fi
  shift
done

echo "Use image: $IMAGE_NAME "

if [[ $SCENARIO_NUMBER = -1 ]]; then
  echo "Choose between Examples:"
  echo "0: OpenDRIVE and OpenSCENARIO (default)"
  echo "1: Replay trajectories"
  echo "2: Replay trajectories with sensors"
  echo "3: OSTAR open-loop without CARLA"
  echo "4: OSMP Proxy (no working example)"
  echo "5: Static Sensor"
  echo "6: Geometrical Sensor model"
  echo "7: SUMO example"
  echo ""
  echo "Enter 0 to 7 to continue, h for more info, e for exit"

  read -p "(0/1/2/3/4/5/6/7/h/e) " SCENARIO_NUMBER
fi

case $SCENARIO_NUMBER in
  0) cp examples/00-opendrive-openscenario/* input/
    ;;
  1) cp examples/01-town10hd-replay-trajectories/* input/
    ;;
  2) cp examples/02-town10hd-replay-trajectories-with-sensor/* input/
    ;;
  3) cp examples/03-osmp-openloop-without-carla/* input/
    ;;
  4) cp examples/04-osmp-proxy/* input/
    echo "Example 04 needs an program to communicate OSI via TCP."
    echo "Currently no demo simulation is available."
    echo ""
    echo "Protocol like https://github.com/OpenSimulationInterface/osi-sensor-model-packaging"
    exit;;
  5) cp examples/05-static-sensor/* input/
    ;;
  6) cp examples/06-geometrical-sensor-model/* input/
    ;;
  7) cp examples/07-sumo/* input/
    ;;
  h) echo "Check out the examples directory for more information about each scenario."
    exit;;
  *) exit;;
esac

mkdir -p output
output_abs_path=$(realpath output)

#Delete old containers if present
if docker ps -a | grep "ostar-single-container"; then
  docker rm ostar-single-container || true
fi

docker run --privileged --net=host --gpus all --name ostar-single-container -e DISPLAY=$DISPLAY -it --mount type=bind,source="$input_abs_path",target=/home/carla/input --mount type=bind,source="$output_abs_path",target=/home/carla/output $IMAGE_NAME $ALL_PARAMETERS

echo "Done. See simulation output in output directory"

