# Quickstart for OSTAR

OSTAR is a set of software tools for automotive simulation.
This is an implementation of the setlevel generic simulation architecture.

Attention: Installation may take a while.

## Cosima, OSMP-Service and Carla-OSI-Service

Connect [Carla Simulator](https://github.com/carla-simulator/carla) through [OSI](https://github.com/OpenSimulationInterface/open-simulation-interface) with OSMP capable FMUs.

### [Cosima](https://github.com/DLR-TS/CoSiMa)

Message broker for OSI messages between OSMP-Services and Carla-OSI-Service.

### [OSMP-Service](https://github.com/DLR-TS/OSMP-Service)

Loads OSMP FMU and communicates with it. One OSMP Service handles one FMU.

### [Carla-OSI-Service](https://github.com/DLR-TS/Carla-OSI-Service)

Connects to Carla C++ API and creates OSI messages requested by CoSiMa and interprets OSI TrafficUpdate to vehicles in Carla.

### Requirements

System capable to run containers. \
Installation of Carla 0.9.13.

### Installation

```sh
git clone https://github.com/DLR-TS/OSTAR-Quickstart.git
cd OSTAR-Quickstart
chmod +x setup.sh run.sh
./setup.sh
```

If Carla is not running on the same machine change carla_host in OSMPDummy/config.yml\
Start Carla simulator.\
Spawn a hero vehicle in Carla, e.g. via manual_control.py

```sh
./run.sh
```

The simulation should change to stepmode.
After 30 seconds the cosima should stop.
The Carla-OSI-Service resumes and unfreezes Carla after 5 seconds.

---

## ASC23

Satz

### Requirements

System capable to run containers.
