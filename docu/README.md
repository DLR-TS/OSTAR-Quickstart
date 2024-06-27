# Documentation

OSTAR contains three main components: CoSiMa, OSMP-Service and Carla-OSI-Service.
It connects [CARLA Simulator](https://carla.org) through [OSI](https://www.asam.net/standards/detail/osi) with OSMP capable FMUs.
The configuration is done via [YAML configuration file](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu/Configuration.md)\
[Current support for each OSI message](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu/OSI_Field_Implementation.md)

## [CoSiMa](https://github.com/DLR-TS/CoSiMa)

Message broker for OSI messages between OSMP-Services and Carla-OSI-Service.

## [OSMP-Service](https://github.com/DLR-TS/OSMP-Service)

Loads OSMP FMU and communicates with it.
One OSMP Service handles one FMU.

## [Carla-OSI-Service](https://github.com/DLR-TS/Carla-OSI-Service)

Connects to Carla C++ API and creates OSI messages requested by CoSiMa and interprets OSI TrafficUpdate to vehicles in Carla.
Can also spawn vehicles and sensors.

# Distributed Simulation 
If Carla is not running on the same machine change carla_host in then change configDistributedSimulation.yml accordingly.\
Start Carla simulator.\
Spawn a hero vehicle in Carla e.g. with manual_control.py

## Running the default distributed simulation
The simulation should change to stepmode.
After 30 seconds the cosima stops.
The Carla-OSI-Service resumes and unfreezes Carla after 5 seconds.
The simulation output is located in the second OSMP Service Container.
