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
Only move to a distributed simulation if neccessary. The distributed simulation starts OSTAR component in separate docker containers.
This is useful, if models only work in custom environments.

```sh
git clone https://github.com/DLR-TS/OSTAR-Quickstart.git
cd OSTAR-Quickstart
chmod +x *.sh
./setup.sh --docker
```

## Run

To run the simulation choose between the provided examples.
You can select the scenarios interactively or as a path by parameter.

```sh
./run.sh --visual
```

Available runtime parameter are:\
**[scenario directory]** directory with scenario files\
**[image]** optional image selection\
**[--visual]** to open CARLA window\
**[--verbose]** to enable verbose logs

The simulation runs the scenario and will generate [OSI](https://www.asam.net/standards/detail/osi) trace files in a new output directory.
Images are stored in a separate directory.

# Further information

Check out the OSTAR documentation at [OSTAR Quickstart](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu).

# Contacts

bjoern.bahn@dlr.de
frank.baumgarten@dlr.de
opensource-ts@dlr.de

This software was originally developed as part of [SetLevel](https://setlevel.de/).
