# Quickstart for OSTAR

OSTAR is a set of software tools for automotive simulation.
OSTAR enables a simulation where vehicles in CARLA are controlled by external models.
Theses models are packaged with FMI and use OSI messages for communication.
The integration of theses models to CARLA is given by the GroundTruth, SensorView and TrafficUpdate messages.

This Quickstart shows how to use easy use OSTAR in a single container.
Further customization is possible and can be found in the [documentation](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu).
OSTAR is an implementation of the [SetLevel](https://setlevel.de/en) generic simulation architecture.

## Requirements

System capable to run docker containers and a GPU to support CARLA.\
40 GB free storage

## Installation

In setup.sh you can choose to download or build **SCS** (Single Container Simulation) or build **DS** (Distributed Simulation).\
It is recommended to start with download (or build) of **SCS** and only move to a distributed simulation if neccessary.\
Your choice is stored and can be changed by calling setup.sh again.\
The first build of **SCS** takes up to one hour.

```sh
git clone https://github.com/DLR-TS/OSTAR-Quickstart.git
cd OSTAR-Quickstart
chmod +x *.sh
./setup.sh
```

## Run

The run.sh script calls the setup.sh script if no simulation choice is saved in setup.txt.

```sh
./run.sh --visual
```

The simulation runs the scenario and will generate [OSI](https://www.asam.net/standards/detail/osi) trace files in a new output directory.\
Available runtimeparameter are:\
**--visual** to open CARLA window\
**--verbose** to enable verbose logs\
**<0-7>** to select a predefined scenario by index

# Further information

Check out the OSTAR documentation at [OSTAR Quickstart](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu).

# Contacts

bjoern.bahn@dlr.de
frank.baumgarten@dlr.de
opensource-ts@dlr.de

This software was originally developed as part of [SetLevel](https://setlevel.de/).
