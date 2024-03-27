#!/bin/bash

#Extract and unzip imported files from the directory.
cd /data/inputs; tar -xvf $(find /data/inputs/ -name "0")

#Create input directory if not used by mounted volume
mkdir -p input/

#Write default files if not provided by mounted volume
find /data/inputs/ -type d -name "scenario" | while read dir; do
cp -r "$dir"/* /home/carla/input/

#Start CARLA
#./CarlaUE4.sh -nosound &
./CarlaUE4.sh -nosound -RenderOffScreen &

echo "Starting Carla takes a while... Script will continue in 30 seconds"
sleep 30s #30 seconds is the safer option, 15 seconds works most of the time

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

#Copy simulation results in output directory
mv *.png /data/outputs/
mv *.osi /data/outputs/

sleep 1s

echo "OSTAR simulation done"
