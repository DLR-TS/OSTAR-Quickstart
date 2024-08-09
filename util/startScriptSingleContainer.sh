#!/bin/bash

XODR_FILE=$(find /home/carla/input/ -type f -name "*.xodr" | head -n 1)
XOSC_FILE=$(find /home/carla/input/ -type f -name "*.xosc" | head -n 1)
YAML_FILE=$(find /home/carla/input/ -type f -name "*.yml" | head -n 1)
VISUAL=false
VERBOSE=false

while [[ "$#" -gt 0 ]]; do
  if [[ $1 = "--verbose" ]]; then
    VERBOSE=true
  fi
  if [[ $1 = "--visual" ]]; then
    VISUAL=true
  fi
  shift
done

echo "XODR_FILE: $XODR_FILE XOSC_FILE: $XOSC_FILE YAML_FILE: $YAML_FILE VISUAL: $VISUAL VERBOSE: $VERBOSE"

#Start CARLA
if $VISUAL; then
  ./CarlaUE4.sh -nosound &
else
  ./CarlaUE4.sh -nosound -RenderOffScreen &
fi

echo "Starting Carla takes a while... Script will continue in 30 seconds"
sleep 30s #30 seconds is the safer option, 15 seconds works most of the time

#Check for openDRIVE map
if [ -f "$XODR_FILE" ]; then
  echo "Load openDRIVE file: $XODR_FILE"
  python3 PythonAPI/util/config.py -x $XODR_FILE
fi

if $VISUAL; then
  echo "Sleep 5 seconds to allow manual change of view direction on new map."
  sleep 5s
fi

#Start OSTAR CoSimulationManager
if [[ -f "$YAML_FILE" ]]; then
  echo "Load YML file: $YAML_FILE"
  if [[ -f "$XOSC_FILE" ]]; then
    if $VERBOSE; then
      ./CoSimulationManager -sr -v $YAML_FILE &
    else
      ./CoSimulationManager -sr $YAML_FILE &
    fi
  else
    if $VERBOSE; then
      ./CoSimulationManager -v $YAML_FILE
    else
      ./CoSimulationManager $YAML_FILE
    fi
  fi
else
  echo "No .yml file found in input directory."
  exit
fi

sleep 1s

#Start CARLA Scenario Runner

if [[ -f "$XOSC_FILE" ]]; then
  echo "Load openSCENARIO file: $XOSC_FILE"
  python3 app/scenario_runner/scenario_runner.py --sync --openscenario $XOSC_FILE
fi

sleep 1s

#Create input directory if not override by mounted volume
mkdir -p /home/carla/output/images

#Copy simulation results in output directory
mv *.png /home/carla/output/images
mv *.osi /home/carla/output/

echo "OSTAR simulation done"

