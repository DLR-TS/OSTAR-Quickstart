# YAML Configuration

In general the simulation configuration consists of a base simulator and several additional simulation model adapters.

## Base simulator

At the moment there is one base simulator (CARLA) as well as a dummy implemented.\
The base simulator will be contacted, if an input of a model is not filled by an output of an other model.
The dummy can be used to run a simulation without CARLA.

### Carla OSI Service Configuration
```
- simulator: CARLA
  carla\_host: localhost
  carla\_port: 2000
  client\_host: localhost
  client\_port: 51425
  autostart: false
  delta: 0.03
  transaction\_timeout: 30000
  do\_step\_timeout: 30000
  initialisation\_timeout: 60000
  additional\_parameters: ""
  sensor\_view\_config:
  - base\_name: OSMPSensor1
    parent\_name: hero
    sensor\_type: camera
    camera\_sensor\_mounting\_position: {x: 0, y: 0, z: 0, roll: 0, pitch: 0, yaw: 0}
    number\_of\_pixels\_horizontal: 1280
    number\_of\_pixels\_vertical: 720
    field\_of\_view\_horizontal: 75
```

carla\_host and carla\_port: host and port of CARLA instance\
client\_host and client\_port: host and port of Carla OSI Service\
autostart: start Carla OSI Service on system, executable needs to be at same location as CoSiMa\
delta: simulation stepsize in seconds\
transaction\_timeout: timeout for gRPC getter and setter calls\
do\_step\_timeout: timeout for gRPC Do\_Step calls\
initialisation\_timeout: timeout for gRPC call for initialisation of Carla OSI Service\
additional\_parameters: [See here](https://github.com/DLR-TS/OSTAR-Quickstart/tree/main/docu/Carla\_OSI\_Service\_Configuration.md)\
sensor\_view\_config: spawn sensors in Carla\
base\_name: Identifier of the sensor, can be used by OSMP Service input base\_name. **Currently needs to start with OSMP**\
parent\_name: __world__ for static sensor, otherwise name of vehicle to attach the sensor accordingly\
sensor\_type: currently supported are camera, lidar, radar and ultrasonic\
prefixed\_fmu\_variable\_name: identifier of sensor to connect this sensor output to a specific FMI input\
sensor\_mounting\_position: position of sensor in world or relative to vehicle

### Dummy Simulator

The dummy simulator needs to be used if a simulation without a connection to Carla is required.

```
- simulator: DUMMY
  delta: 0.03
```

delta: simulation stepsize in seconds

## Additional model adapters

### OSMP Service

```
- simulator: OSMP
  model: /Path/to/FMU.fmu
  host: localhost
  port: 51426
  autostart: true
  transaction\_timeout: 5000
  do\_step\_timeout: 5000
  input:
      - {interface\_name: OSMPSensorView, base\_name: OSMPSensorViewGroundTruth}
  output:
      - {interface\_name: OSMPSensorData, base\_name: OSMPSensorData}
  parameter:
      - {name: "profile", value: "Ibeo\_LUX\_2010"}
```

model: path where FMU is located, if not found by CoSiMa the OSMP Service will try to load the file directly. It can also be an OSI trace file as an input.\ 
host and port: host and port of OSMP Service\
autostart: start Carla OSI Service on system, executable needs to be at same location as CoSiMa\
transaction\_timout: timeout for gRPC getter and setter calls\
do\_step\_timeout: timeout for gRPC Do\_Step calls\
input and output: list of inputs/outputs\
  interface\_name: name of variable in modeldescription.xml of FMU, needs to be the same as OSI message name, can contain In and Out as a prefix\
  base\_name: name for matching the input and output inside CoSiMa\
parameter: list of parameters for configuration of FMU. Parameters are set before the simulation starts and can not be changed during the simulation run.

### SUMO Adapter

```
- simulator: SUMO
  model: config.sumocfg
  output:
    - {interface\_name: "OSMPTrafficUpdate", base\_name: "OSMPTrafficUpdate"}
```

model: path to SUMO configuration file.\
input and output: list of inputs/outputs\
  interface\_name: name of variable in modeldescription.xml of FMU, needs to be the same as OSI message name, can contain In and Out as a prefix\
  base\_name: name for matching the input and output inside CoSiMa\

### Proxy Adapter

The proxy adapter sends the size of the message and then the message itself to a proxy simulator.\
There is not explicit call of a __doStep__ possible.\
The receiving side works the same as the sending side.

```
- simulator: PROXY
  host: 192.168.1.2
  port: 8083
  input:
    - {interface\_name: "OSMPSensorData", base\_name: "OSMPSensorData"}
  output:
    - {interface\_name: "OSMPTrafficUpdate", base\_name: "OSMPTrafficUpdate"}
```

host and port: host and port of proxy simulator\
input and output: list of inputs/outputs. If several messages are to be transmitted the order in this file will be the order the messages will be send to the proxy simulator.
  interface\_name: name is irrelevant\
  base\_name: name for matching the input and output inside CoSiMa

## Specials

base\_name: **"OSMPSensorView[x]"** for sensor input if automatic sensor generation by the FMI SensorViewConfigRequest shall be used\
base\_name: **"OSMPSelfDefinedSensorX"** The name of a sensor defined by the yml configuration file must begin with OSMP\
base\_name: **"OSMPSensorViewGroundTruth"** creates a default SensorViewMessage with a complete GroundTruth without any special sensorview

