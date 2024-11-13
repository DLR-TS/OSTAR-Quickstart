# Documentation

OSTAR contains three main components: CoSiMa, OSMP-Service and Carla-OSI-Service.
It connects [CARLA Simulator](https://carla.org) through [OSI](https://www.asam.net/standards/detail/osi) with [OSMP](https://opensimulationinterface.github.io/osi-documentation/) capable [FMUs](https://fmi-standard.org/).
The configuration is done via [YAML configuration file](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu/Configuration.md)\
[Current support for each OSI message](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu/OSI_Field_Implementation.md)
OSTAR supports OSI 3.7.0 and FMI 2.0.

<<<<<<< HEAD
Runnable examples are [here](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/scenarios).
=======
Runnable examples are [here](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/examples).
>>>>>>> main

To configure your own scenario start with altering any example.

## [CoSiMa](https://github.com/DLR-TS/CoSiMa)

Message broker for OSI messages between OSMP-Services and Carla-OSI-Service.
The CoSiMa is always the last component to be started as it connects to the various parts.
The [YAML configuration file](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu/Configuration.md) is given via command line parameter.

## [OSMP-Service](https://github.com/DLR-TS/OSMP-Service)

Loads OSMP FMU and communicates with it.
One OSMP-Service handles one FMU.
The OSMP-Service supports trajectory files as input and creates OSI TrafficUpdate messages from it.
It is also possible to configure the OSMP-Service as a logger to write OSI trace files.\
The configuration is set by CoSiMa [YAML configuration file](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu/Configuration.md)

## [Carla-OSI-Service](https://github.com/DLR-TS/Carla-OSI-Service)

Connects to Carla C++ API and creates OSI messages requested by CoSiMa and interprets OSI TrafficUpdate to vehicles in Carla.
Can also spawn vehicles and sensors.\
The configuration is set by CoSiMa [YAML configuration file](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu/Configuration.md)

# Distributed Simulation

If Carla is not running on the same machine change carla_host in then change configDistributedSimulation.yml accordingly.\
Start Carla simulator.\
Spawn a hero vehicle in Carla e.g. with manual_control.py

## Running the default distributed simulation

The simulation should change to stepmode.
After 30 seconds the cosima stops.
The Carla-OSI-Service resumes and unfreezes Carla after 5 seconds.
The simulation output is located in the second OSMP-Service Container.

