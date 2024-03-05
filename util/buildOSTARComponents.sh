#!/bin/bash
docker build -f dockerfiles/Dockerfile4OstarCore -t ostar:core_builder .

OSTAR_DIR=../OSTAR

# ==============================================================================
# -- Get and compile OSMP-Service ----------------------------------------------
# ==============================================================================

OSMPSERVICE_VERSION=dev
OSMPSERVICE_REPO=https://github.com/DLR-TS/OSMP-Service.git
OSMPSERVICE_INSTALL=OSMP-Service

echo "Build OSTAR component ${OSMPSERVICE_INSTALL} from DLR-TS (German Aerospace Center Institute of Transportation Systems)"

if [[ -d ${OSTAR_DIR}/${OSMPSERVICE_INSTALL} ]] ; then
  echo "OSMP-Service already installed."
else
  echo "Retrieving OSMP-Service."
  pushd ${OSTAR_DIR} > /dev/null
  git clone ${OSMPSERVICE_REPO}
  popd >/dev/null

  pushd ${OSTAR_DIR}/${OSMPSERVICE_INSTALL} >/dev/null

  git checkout ${OSMPSERVICE_VERSION}
  docker build -f Dockerfile18 -t ostar:osmpservice-18 .

  popd >/dev/null

fi

# ==============================================================================
# -- Get and compile Cosima ----------------------------------------------------
# ==============================================================================

COSIMA_VERSION=dev
COSIMA_REPO=https://github.com/DLR-TS/CoSiMa.git
COSIMA_INSTALL=CoSiMa

echo "Build OSTAR component ${COSIMA_INSTALL} from DLR-TS (German Aerospace Center Institute of Transportation Systems)"

if [[ -d ${OSTAR_DIR}/${COSIMA_INSTALL} ]] ; then
  echo "CoSiMa already installed."
else
  echo "Retrieving CoSiMa."
  pushd ${OSTAR_DIR} > /dev/null
  git clone ${COSIMA_REPO}
  popd >/dev/null

  pushd ${OSTAR_DIR}/${COSIMA_INSTALL} >/dev/null

  git checkout ${COSIMA_VERSION}
  docker build -f Dockerfile18 -t ostar:cosima-18 .

  popd >/dev/null

fi

# ==============================================================================
# -- Get and compile Carla-OSI-Service -----------------------------------------
# ==============================================================================

CARLAOSISERVICE_VERSION=dev
CARLAOSISERVICE_REPO=https://github.com/DLR-TS/Carla-OSI-Service.git
CARLAOSISERVICE_INSTALL=Carla-OSI-Service

echo "Build OSTAR component ${CARLAOSISERVICE_INSTALL} from DLR-TS (German Aerospace Center Institute of Transportation Systems)"

if [[ -d ${OSTAR_DIR}/${CARLAOSISERVICE_INSTALL} ]] ; then
  echo "Carla-OSI-Service already installed."
else
  echo "Retrieving Carla-OSI-Service."
  pushd ${OSTAR_DIR} > /dev/null
  git clone ${CARLAOSISERVICE_REPO}
  popd >/dev/null

  pushd ${OSTAR_DIR}/${CARLAOSISERVICE_INSTALL} >/dev/null

  git checkout ${CARLAOSISERVICE_VERSION}
  docker build -f Dockerfile18 -t ostar:carla-osi-service-18 .

  popd >/dev/null

fi

