# Quickstart for OSTAR

OSTAR is a set of software tools for automotive simulation.
This is an implementation of the [SetLevel](https://setlevel.de/en) generic simulation architecture.

OSTAR enables a simulation where vehicles in CARLA are controlled by external models.
Theses models are packaged with FMI and use OSI messages for communication.
The integration of theses models to CARLA is given by the GroundTruth, SensorView and TrafficUpdate messages.

This Quickstart contains two setups.

* Singe Container Simulation (**SCS**)
* Distributed Simulation (**DS**)

## CoSiMa, OSMP-Service and Carla-OSI-Service

Connect [CARLA Simulator](https://carla.org) through [OSI](https://www.asam.net/standards/detail/osi) with OSMP capable FMUs.

### [CoSiMa](https://github.com/DLR-TS/CoSiMa)

Message broker for OSI messages between OSMP-Services and Carla-OSI-Service.

### [OSMP-Service](https://github.com/DLR-TS/OSMP-Service)

Loads OSMP FMU and communicates with it.
One OSMP Service handles one FMU.

### [Carla-OSI-Service](https://github.com/DLR-TS/Carla-OSI-Service)

Connects to Carla C++ API and creates OSI messages requested by CoSiMa and interprets OSI TrafficUpdate to vehicles in Carla.
Can also spawn vehicles and sensors.

## Requirements SCS

System capable to run docker containers and a GPU to support CARLA.\
40 GB free storage

## Requirements DS

System capable to run docker containers.\
Installation of Carla 0.9.13.\
May be on a different computer.

## Installation

In setup.sh you can choose to build **SCS** or **DS**.\
Your choice is stored and can be changed by calling setup.sh again.\
First installation of **SCS** takes up to one hour (with 50 Mbps download speed).

```sh
git clone https://github.com/DLR-TS/OSTAR-Quickstart.git
cd OSTAR-Quickstart
chmod +x *.sh
./setup.sh
```

Only **DS**:\
If Carla is not running on the same machine change carla_host in then change configDistributedSimulation.yml accordingly.\
Start Carla simulator.\
Spawn a hero vehicle in Carla e.g. with manual_control.py

## Run

The run.sh script calls the setup.sh script if no simulation choice is saved in setup.txt.

```sh
./run.sh
```

Only **SCS**:\
The simulation runs the complete scenario and will generate output in a new output directory.

Only **DS**:\
The simulation should change to stepmode.
After 30 seconds the cosima stops.
The Carla-OSI-Service resumes and unfreezes Carla after 5 seconds.
The simulation output is located in the second OSMP Service Container.

---

## [ASC23](https://github.com/DLR-TS/asc23)

The ASC23 (Automotive Simulation Standard Compliance Check Container) is a separate tool suite that combines scripts and tools to validate standardized data files.

### Requirements

System capable to run containers and has access to Github and PiPy repositories.
