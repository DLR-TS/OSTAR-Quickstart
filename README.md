# Quickstart for OSTAR

OSTAR is a set of software tools for automotive simulation.
OSTAR enables a simulation where vehicles in CARLA are controlled by external models.
Theses models are packaged with FMI and use OSI messages for communication.
The integration of theses models to CARLA is given by the GroundTruth, SensorView and TrafficUpdate messages.

This Quickstart shows how to use OSTAR.
Further customization is possible and can be found in the [documentation](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu).
OSTAR is an implementation of the [SetLevel](https://setlevel.de/en) generic simulation architecture.
OSTAR also supports [SUMO](https://eclipse.dev/sumo/) to generate traffic scenarios.

## Requirements

System capable to run docker containers and a GPU to support CARLA.

## Installation

In the setup.sh script, you can choose to either download or build **SCS** (Single Container Simulation) or build **DS** (Distributed Simulation).\
It is recommended to start with the download of **SCS** since the first build of **SCS** takes up to one hour.
Only move to a distributed simulation if neccessary, like the integration of a Windows only FMU into the simulation.\
Your selection is stored in setup.txt and can be changed by calling setup.sh again.\

```sh
git clone https://github.com/DLR-TS/OSTAR-Quickstart.git
cd OSTAR-Quickstart
chmod +x *.sh
./setup.sh --docker
```

## Run

To run the simulation choose between the provided examples.
You can select the scenarios interactively or by parameter.

```sh
./run.sh --visual
```

Available runtimeparameter are:\
**--visual** to open CARLA window\
**--verbose** to enable verbose logs\
**<0-7>** to select a predefined scenario by index\

The simulation runs the scenario and will generate [OSI](https://www.asam.net/standards/detail/osi) trace files in a new output directory.

# Further information

Check out the OSTAR documentation at [OSTAR Quickstart](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu).

# Contacts

bjoern.bahn@dlr.de
frank.baumgarten@dlr.de
opensource-ts@dlr.de

This software was originally developed as part of [SetLevel](https://setlevel.de/).
