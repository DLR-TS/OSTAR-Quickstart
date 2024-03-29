# Models

OSTAR can load [FMI](https://fmi-standard.org/) models, which communicate via [OSI](https://github.com/OpenSimulationInterface/open-simulation-interface) messages.

By default the Quickstart builds four Open Source models from [asc(s e.V. - ENVITED Open Source Model & Simulation Library](https://github.com/openMSL).

* [SL 1-1 Reflection Based Radar Object Model](https://github.com/openMSL/sl-1-1-reflection-based-radar-object-model)
* [SL 1-2 Reflection Based Lidar Object Model](https://github.com/openMSL/sl-1-2-reflection-based-lidar-object-model)
* [SL 1-3 Object Based Generic Perception Object Model](https://github.com/openMSL/sl-1-3-object-based-generic-perception-object-model)
* [SL 1-4 Object Based Camera Object Model](https://github.com/openMSL/sl-1-4-object-based-camera-object-model)

Use the FMU names in the configuration file to load these models.

## SL 1-1 Reflection Based Radar Object Model

FMU Name: ReflectionBasedRadarModel.fmu\
Version: v2.0

## SL 1-2 Reflection Based Lidar Object Model

:warning: **Current version not compliant with official ASAM OSI. Model not available for simulation**\
There might be empty fields or additional fields in OSI messages.\
FMU Name: ReflectionBasedLidarModel.fmu\
Version: v1.1

## SL 1-3 Object Based Generic Perception Object Model

FMU Name: ObjectBasedGenericPerceptionObjectModel.fmu\
Version: v2.0

## SL 1-4 Object Based Camera Object Model

FMU Name: ObjectBasedCameraObjectModel.fmu\
Version: main

Thanks to asc(s e.V. for their open source model libraray.
