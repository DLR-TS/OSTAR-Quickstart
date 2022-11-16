#!/bin/bash
#Download demo of OSTAR

# ==============================================================================
# -- Get and compile OSMP-Service ----------------------------------------------
# ==============================================================================

OSMPSERVICE_VERSION=1.0
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

COSIMA_VERSION=1.0
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

CARLAOSISERVICE_VERSION=1.0
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

OSMPMODEL_DIR=OSMPDummy
OSMPMODEL_NAME=${OSMPMODEL_DIR}/OSMPDummySensor.fmu
OSMPMODEL_VERSION=1.3.0

if [[ -f ${OSMPMODEL_NAME} ]] ; then
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
  docker cp dummysensor:/model/examples/build/OSMPDummySensor/OSMPDummySensor.fmu ${OSMPMODEL_NAME}
  docker rm -f dummysensor

fi

echo "Done"

