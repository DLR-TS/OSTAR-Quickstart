#!/bin/bash
#Prepare input
rm -r input
mkdir input
input_abs_path=$(realpath input)

echo "Copy FMU models into input directory!"
cp models/*.fmu input/

echo "Choose between Examples:"
echo "0: OpenDRIVE and OpenSCENARIO (default)"
echo "1: Town10 Replay trajectories"
echo "2: Town10 Replay trajectories with sensors"
echo "3: OSTAR open-loop without CARLA"
echo "4: OSMP Proxy (not working)"
echo "5: Town10 Geometrical Sensor"
echo "6: Town10 Geometrical Sensor model"
echo ""
echo "Enter 0 to 6 to continue, h for more info, e for exit"

read -p "(0/1/2/3/4/5/6/h/e) " answer

case $answer in
  0 ) cp examples/00-opendrive-openscenario/* input/
    ;;
  1 ) cp examples/01-town10hd-replay-trajectories/* input/
    ;;
  2 ) cp examples/02-town10hd-replay-trajectories-with-sensor/* input/
    ;;
  3 ) cp examples/03-osmp-openloop-without-carla/* input/
    ;;
  4 ) cp examples/04-osmp-proxy/* input/
    ;;
  5 ) cp examples/05-geometrical-sensor/* input/
    ;;
  6 ) cp examples/06-geometrical-sensor-model/* input/
    ;;
  h ) echo "Check out the examples directory for more information about each scenario."
    exit;;
  * ) exit;;
esac

#Prepate output
mkdir output
output_abs_path=$(realpath output)

#Delete old containers if present
if docker ps -a | grep "ostar-single-container"; then
	docker rm ostar-single-container || true
fi

docker run --privileged --net=host --gpus all --name ostar-single-container -e DISPLAY=$DISPLAY -it --mount type=bind,source="$input_abs_path",target=/home/carla/input --mount type=bind,source="$output_abs_path",target=/home/carla/output ostar:single_container

echo "Done. See simulation output in output directory"

