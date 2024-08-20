# Scenario

This folder contains two scenarios. The first is for a single container simulation, the second for a distributed simulation.

## Single Container Simulation

map.xodr OpenDRIVE map is loaded by [CARLA](https://github.com/carla-simulator/carla).
scenario.xosc OpenSCENARIO scenario is loaded by [CARLA Scenario Runner](https://github.com/carla-simulator/scenario_runner).
The scenario runner contains changes to synchronise with OSTAR.
configSingleContainerSimulation.yml is loaded by CoSiMa and contains the configuration of the FMUs.

The included FMUs will be copied into this directory when running the run.sh in the root directory.
Then this directory is mounted by the container.
