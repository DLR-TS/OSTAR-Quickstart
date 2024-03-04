#!/bin/bash
#Download of OSTAR for single container

pushd $(dirname "$0") > /dev/null

# ==============================================================================
# -- Build models --------------------------------------------------------------
# ==============================================================================

/bin/bash buildModels.sh

# ==============================================================================
# -- Build OSTAR core components -----------------------------------------------
# ==============================================================================

/bin/bash buildOSTARComponents.sh

# ==============================================================================
# -- Build Carla Scenario Runner -----------------------------------------------
# ==============================================================================

OSTAR_DIR=../OSTAR
CARLASCENARIORUNNER_VERSION=v0.9.13
CARLASCENARIORUNNER_REPO=https://github.com/carla-simulator/scenario_runner.git
CARLASCENARIORUNNER_INSTALL=scenario_runner

if [[ -d ${OSTAR_DIR}/${CARLASCENARIORUNNER_INSTALL} ]] ; then
  echo "Carla Scenario Runner already installed."
else
  echo "Retrieving Carla Scenario Runner."
  pushd ${OSTAR_DIR} > /dev/null
  git clone ${CARLASCENARIORUNNER_REPO}
  popd >/dev/null

  pushd ${OSTAR_DIR}/${CARLASCENARIORUNNER_INSTALL} >/dev/null

  git checkout ${CARLASCENARIORUNNER_VERSION}
  #no build needed, will be build in final ostar container

  popd >/dev/null

fi

echo "Setup changes in CARLA Scenario Runner to work with OSTAR."

cp scenario_runner_changes/scenario_runner.py ${OSTAR_DIR}/scenario_runner/scenario_runner.py
cp scenario_runner_changes/scenario_manager.py ${OSTAR_DIR}/scenario_runner/srunner/scenariomanager/scenario_manager.py

echo "Build of components complete. Begin integration into carla docker container."
popd >/dev/null

# ==============================================================================
# -- Build OSTAR Single Container ----------------------------------------------
# ==============================================================================

docker buildx build -t ostar:single_container -f util/dockerfiles/DockerfileSingleContainer .

