# Examples:

All examples need a CARLA instance running at the same computer.
Otherwise configure _carla_host_ (and _carla_port_) in the yml files.

## 01 Town10HD Replay Trajectories

Replays trajectories of one ego vehicle and three other vehicles.
Load Town10HD in Carla before starting the simulation.

Uses 1x CoSiMa, 1x Carla-OSI-Service, 1x OSMP Service.

<img src="../../img/01.jpg" alt="drawing" width="50%"/>

## 02 Town10HD Replay Trajectories with sensor

Replays the same trajectories as in 01.
Additionally a sensor in placed on the ego vehicle.
The first OSMP Service loads the sensor FMU and configures it with given parameters, like _profile_ = SCALA_1, Ibeo_LUX_2010, LongRange_Radar or MidRange_Radar.
The [FMU](https://github.com/openMSL/sl-1-3-object-based-generic-perception-object-model) receives a SensorView message with all GroundTruth information.
The second OSMP Services saves the SensorView and the SensorData messages.

Uses 1x CoSiMa, 1x Carla-OSI-Service, 2x OSMP Service.

## 03 OSMP Openloop without Carla

OSTAR enables simulation runs without Carla and replaces it with a dummy.
This example reads the replay in the first OSMP Service and saves it with the second OSMP Service.
Other FMUs can be configured to receive the input from the reading OSMP Service and write its output to the writing OSMP Service.

Uses 1x Cosima, 2x OSMP Service.

## 04 OSMP Proxy

Uses a compatible functionality of the [OSMPCNetworkProxy FMU](https://github.com/OpenSimulationInterface/osi-sensor-model-packaging) to connect via TCP connection.
Should be used with care since only OSI messages are transmitted.
Simulation control messages are not supported by this interface, like _doStep_ or _endSimulation_.
Since it is not used frequently there is no easy example.
Just get in touch with us, if you need more help with this feature.

## 05 Advanced sensors: Camera sensor by configuration file

Replays trajectories of one ego vehicle and three other vehicles.
OSTAR creates and configures a camera sensor on the ego vehicle.
The image is saved as an OSI trace file.
Additionally each image is saved by the receiving OSMP Service as a separate png file.
Lidar and Radar sensors work similar to this example.
OSMP Service currently only has a spcific behavior for camera images in the sensorview message.

Uses 1x CoSiMa, 1x Carla-OSI-Service, 2x OSMP Service

## 06 Advanced sensors: Radar sensor by FMU

Replays trajectories of one ego vehicle and three other vehicles.
OSTAR creates and configures a radar sensor based on a given FMU, like the [openMSL model](https://github.com/openMSL/sl-1-1-reflection-based-radar-object-model) on the ego vehicle.
Camera and Lidar sensors work similar to this example.

Uses 1x CoSiMa, 1x Carla-OSI-Service, 3x OSMP Service
