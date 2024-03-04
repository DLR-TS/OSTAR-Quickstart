#!/bin/bash

#Create input directory if not used by mounted volume
mkdir -p input/

#Write default files if not provided by mounted volume
cp -n /home/carla/ostar/default/* /home/carla/input/

#Start CARLA
#./CarlaUE4.sh -nosound &
./CarlaUE4.sh -nosound -RenderOffScreen &

echo "Starting Carla takes a while... Script will continue in 15 seconds"
sleep 15s

#Load openDRIVE map
python3 PythonAPI/util/config.py -x /home/carla/input/map.xodr

#Start OSTAR components
./ostar/CARLA_OSI_Service &
./ostar/OSMPService 51426 &
./ostar/OSMPService 51427 &
./ostar/OSMPService 51428 &
./ostar/CoSimulationManager -sr /home/carla/input/config.yml &

sleep 1s

#Start CARLA Scenario Runner
python3 app/scenario_runner/scenario_runner.py --sync --openscenario /home/carla/input/scenario.xosc

sleep 1s

#Create input directory if not override by mounted volume
mkdir -p /home/carla/output/images

#Copy simulation results in output directory
mv *.png /home/carla/output/images
mv *.osi /home/carla/output/

sleep 1s

echo "OSTAR simulation done"

