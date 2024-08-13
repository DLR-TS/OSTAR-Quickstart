#!/bin/bash

echo "Setup OSTAR"

DOCKER_DOWNLOAD=false
DOCKER_BUILD=false
DOCKER_DISTRIBUTED=false

while [[ "$#" -gt 0 ]]; do
	echo $1
	case $1 in
		--docker) DOCKER_DOWNLOAD=true ;;
		--build) DOCKER_BUILD=true ;;
		--distributed) DOCKER_DISTRIBUTED=true ;;
	esac
	shift
done

if $DOCKER_DOWNLOAD || $DOCKER_BUILD || $DOCKER_DISTRIBUTED; then
	echo "Use runtime parameter"
	if $DOCKER_DISTRIBUTED; then
		answer=2
	fi
	if $DOCKER_BUILD; then
		answer=1
	fi
	if $DOCKER_DOWNLOAD; then
		answer=0
	fi
else
	echo "Choose between setups:"
	echo "0: Download Single Container"
	echo "1: Build Single Container"
	echo "2: Build Distributed Container Simulation"
	echo ""
	echo "Enter 0 to 2 to continue the setup, h for more info, e for exit"
	read -p "(0/1/2/h/e) " answer
fi

case $answer in
	0) echo "SingleContainerDockerhub" > setup.txt
		/bin/bash util/downloadSingleContainer.sh;
		exit;;
	1) echo "SingleContainerLocal" > setup.txt
		/bin/bash util/setupSingleContainer.sh;
		exit;;
	2) echo "DistributedSimulation" > setup.txt
		/bin/bash util/setupDistributedSimulation.sh;
		exit;;
	h) echo "The single container simulation combines all OSTAR components, all openMSL models, a customized version of the CARLA scenario runner together with CARLA."
		echo ""
		echo "The distributed simulation is distributed as several containers."
		echo "CARLA is not part of this setup process and needs to be provided via other ways."
		echo "All OSTAR components can run on Linus and Windows."
		echo "This allows for flexible setups as well as FMUs running with Windows dependencies like Matlab models."
		echo "The setup uses an empty sensormodel from ASAM OSI and demostrates the possibilities."
		echo ""
		continue;;
	e) exit;;
	*) echo "invalid response";;
esac

