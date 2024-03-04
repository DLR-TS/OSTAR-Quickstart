#!/bin/bash

echo "Setup OSTAR"

while true; do

echo "Choose between setups:"
echo "1: Single Container Simulation"
echo "2: Distributed Container Simulation"
echo ""
echo "Enter 1 or 2 to continue the setup, h for more info, e for exit"

read -p "(1/2/h/e) " answer

case $answer in 
	1 ) echo "SingleContainer" > setup.txt
		/bin/bash util/setupSingleContainer.sh;
		exit;;
	2 ) echo "DistributedSimulation" > setup.txt
		/bin/bash util/setupDistributedSimulation.sh;
		exit;;
	h ) echo "The single container simulation combines all OSTAR components, all openMSL models, a customized version of the CARLA scenario runner together in the CARLA Docker container."
		echo ""
		echo "The distributed simulation is distributed as several containers."
		echo "CARLA is not part of this setup process and needs to be provided via other ways."
		echo "All OSTAR components can run on Linus and Windows."
		echo "This allows for flexible setups as well as FMUs running with Windows dependencies like Matlab models."
		echo "The setup uses an empty sensormodel from ASAM OSI and demostrates the possibilities."
		echo ""
		continue;;
	e ) exit;;
	* ) echo "invalid response";;
esac

done

