#!/bin/bash

# ==============================================================================
# -- Download model -----------------------------------------------------------
# ==============================================================================

OSMPMODEL_NAME="ReflectionBasedLidarModel.fmu"
OSMPMODEL_DIR="sl-1-2-reflection-based-lidar-object-model"
OSMPMODEL_URL="https://github.com/openMSL/${OSMPMODEL_DIR}.git"
OSMPMODEL_VERSION=v1.1

echo "Build ${OSMPMODEL_NAME} from asc(s e.V. - ENVITED Open Source Model & Simulation Library"
#change pwd to this directory
cd "$(dirname "$0")"

if [[ -f ${OSMPMODEL_NAME} ]] ; then
  echo "${OSMPMODEL_NAME} already installed."
else
  echo "Retrieving ${OSMPMODEL_URL} with submodules."

  git clone ${OSMPMODEL_URL}
  
  pushd ${OSMPMODEL_DIR} >/dev/null
  
  git checkout ${OSMPMODEL_VERSION}
  git submodule update --init
  
  cp ../../util/dockerfiles/Dockerfile4Model Dockerfile
  docker build -t ostar:${OSMPMODEL_DIR} .
  
  popd >/dev/null
  
  docker create --name temp_model ostar:${OSMPMODEL_DIR}
  docker cp temp_model:/model/cmake-build/${OSMPMODEL_NAME} .
  docker rm -f temp_model

fi
