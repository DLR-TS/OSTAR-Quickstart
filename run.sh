#!/bin/bash

CONFIGURATION_FILENAME=setup.txt

if [ ! -r ${CONFIGURATION_FILENAME} ]; then
	echo "No setup.txt found. Start Setup script."
	/bin/bash setup.sh
	read -p "Installation complete. To run the simulation press any key."
fi

echo "Run OSTAR"

read -r configuration < ${CONFIGURATION_FILENAME}

if [[ "$configuration" == "SingleContainerDockerhub" ]]; then

	echo "Run Single Container"
	/bin/bash util/runSingleContainer.sh "$@";

elif [[ "$configuration" == "SingleContainer" ]]; then

	echo "Run Single Container"
	/bin/bash util/runSingleContainer.sh "$@";

elif [[ "$configuration" == "DistributedSimulation" ]]; then

	echo "Run Single Container"
	/bin/bash util/runDistributedSimulation.sh "$@";

fi

echo "OSTAR Simulation complete!"
echo "Check the output directory to see results."


