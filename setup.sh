#!/bin/bash
#Download demo of OSTAR

# ==============================================================================
# -- Get and compile OSMP-Service ----------------------------------------------
# ==============================================================================

OSMPSERVICE_VERSION=3.5.0
OSMPSERVICE_REPO=https://github.com/DLR-TS/OSMP-Service.git
OSMPSERVICE_INSTALL=OSMP-Service

if [[ -d ${OSMPSERVICE_INSTALL} ]] ; then
  echo "OSMP-Service already installed."
else
  echo "Retrieving OSMP-Service."
  git clone ${OSMPSERVICE_REPO}

  pushd ${OSMPSERVICE_INSTALL} >/dev/null

  git checkout ${OSMPSERVICE_VERSION}
  docker build -t ostar:osmpservice .

  popd >/dev/null

fi

# ==============================================================================
# -- Get and compile Cosima ----------------------------------------------------
# ==============================================================================

COSIMA_VERSION=3.5.0
COSIMA_REPO=https://github.com/DLR-TS/CoSiMa.git
COSIMA_INSTALL=CoSiMa

if [[ -d ${COSIMA_INSTALL} ]] ; then
  echo "CoSiMa already installed."
else
  echo "Retrieving CoSiMa."
  git clone ${COSIMA_REPO}

  pushd ${COSIMA_INSTALL} >/dev/null

  git checkout ${COSIMA_VERSION}
  docker build -t ostar:cosima .

  popd >/dev/null

fi

# ==============================================================================
# -- Get and compile Carla-OSI-Service -----------------------------------------
# ==============================================================================

CARLAOSISERVICE_VERSION=0.9.13-3.5.0
CARLAOSISERVICE_REPO=https://github.com/DLR-TS/Carla-OSI-Service.git
CARLAOSISERVICE_INSTALL=Carla-OSI-Service

if [[ -d ${CARLAOSISERVICE_INSTALL} ]] ; then
  echo "Carla-OSI-Service already installed."
else
  echo "Retrieving Carla-OSI-Service."
  git clone ${CARLAOSISERVICE_REPO}

  pushd ${CARLAOSISERVICE_INSTALL} >/dev/null

  git checkout ${CARLAOSISERVICE_VERSION}
  docker build -t ostar:carla-osi-service .

  popd >/dev/null

fi

# ==============================================================================
# -- Download model -----------------------------------------------------------
# ==============================================================================

OSMPMODEL_DIR=OSMPDummySensor
OSMPMODEL_NAME=${OSMPMODEL_DIR}/OSMPDummySensor.fmu
OSMPMODEL_VERSION=1.3.0

if [[ -d ${OSMPMODEL_DIR} ]] ; then
  echo "OSMP_Example_Model already installed."
else
  echo "Retrieving OSMP_Example_Model with submodules."

  git clone https://github.com/OpenSimulationInterface/osi-sensor-model-packaging.git
  
  pushd osi-sensor-model-packaging >/dev/null
  
  git checkout v${OSMPMODEL_VERSION}
  git submodule update --init
  
  cp ../Dockerfile Dockerfile
  docker build -t ostar:osmp_model .
  
  popd >/dev/null
  
  docker create --name dummysensor ostar:osmp_model
  docker cp dummysensor:/model/examples/build/${OSMPMODEL_NAME} ${OSMPMODEL_NAME}
  docker rm -f dummysensor

fi

# ==============================================================================
# -- Run container -------------------------------------------------------------
# ==============================================================================

#Delete old containers if present
docker rm ostar_carla_osi_service ostar_dummy_fmu ostar_cosima || true

docker run -d --network host --name ostar_carla_osi_service ostar:carla-osi-service &&
docker run -d -p 51426:51425 --name ostar_dummy_fmu ostar:osmpservice ./OSMPService

#Wait for all services to start
sleep 2

docker run -d --network host -v `pwd`/${OSMPMODEL_DIR}:/ostar --name ostar_cosima ostar:cosima ./CoSimulationManager ostar/config.yml

#Run simulation for 30 seconds
sleep 30

# ==============================================================================
# -- Cleanup -------------------------------------------------------------------
# ==============================================================================

docker stop ostar_carla_osi_service ostar_dummy_fmu ostar_cosima
#Not removed for inspection purposes. Will be removed at rerun in section "Run container".

echo "Done"

