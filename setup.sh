#!/bin/bash
#Download demo of OSTAR

# ==============================================================================
# -- Get and compile OSMP-Service ----------------------------------------------
# ==============================================================================

OSMPSERVICE_VERSION=setlevel/v3.2.2
OSMPSERVICE_REPO=https://github.com/DLR-TS/OSMP-Service/archive/refs/tags/${OSMPSERVICE_VERSION}.tar.gz
OSMPSERVICE_BASENAME=OSMP-Service-setlevel-v3.2.2
OSMPSERVICE_INSTALL=OSMP-Service

if [[ -d ${OSMPSERVICE_INSTALL} ]] ; then
  echo "OSMP-Service already installed."
else
  echo "Retrieving OSMP-Service."
  wget ${OSMPSERVICE_REPO}

  echo "Extracting OSMP-Service."
  tar -xf ${OSMPSERVICE_BASENAME}.tar.gz
  mv ${OSMPSERVICE_BASENAME} ${OSMPSERVICE_INSTALL}

  pushd ${OSMPSERVICE_INSTALL} >/dev/null

  docker build -t ostar:osmpservice .

  popd >/dev/null

  rm -Rf ${OSMPSERVICE_BASENAME}.tar.gz
  rm -Rf ${OSMPSERVICE_BASENAME}
fi

# ==============================================================================
# -- Get and compile Cosima ----------------------------------------------------
# ==============================================================================

COSIMA_VERSION=setlevel/v3.2.2
COSIMA_REPO=https://github.com/DLR-TS/CoSiMa/archive/refs/tags/${COSIMA_VERSION}.tar.gz
COSIMA_BASENAME=CoSiMa-setlevel-v3.2.2
COSIMA_INSTALL=CoSiMa

if [[ -d ${COSIMA_INSTALL} ]] ; then
  echo "CoSiMa already installed."
else
  echo "Retrieving CoSiMa."
  wget ${COSIMA_REPO}

  echo "Extracting CoSiMa."
  tar -xf ${COSIMA_BASENAME}.tar.gz
  mv ${COSIMA_BASENAME} ${COSIMA_INSTALL}

  pushd ${COSIMA_INSTALL} >/dev/null

  docker build -t ostar:cosima .

  popd >/dev/null

  rm -Rf ${COSIMA_BASENAME}.tar.gz
  rm -Rf ${COSIMA_BASENAME}
fi

# ==============================================================================
# -- Get and compile Carla-OSI-Service -----------------------------------------
# ==============================================================================

CARLAOSISERVICE_VERSION=0.9.13
CARLAOSISERVICE_REPO=https://github.com/DLR-TS/Carla-OSI-Service/archive/refs/tags/${CARLAOSISERVICE_VERSION}.tar.gz
CARLAOSISERVICE_BASENAME=Carla-OSI-Service-${CARLAOSISERVICE_VERSION}
CARLAOSISERVICE_INSTALL=Carla-OSI-Service

if [[ -d ${CARLAOSISERVICE_INSTALL} ]] ; then
  echo "Carla-OSI-Service already installed."
else
  echo "Retrieving Carla-OSI-Service."
  wget ${CARLAOSISERVICE_REPO}

  echo "Extracting Carla-OSI-Service."
  tar -xf ${CARLAOSISERVICE_BASENAME}.tar.gz
  mv ${CARLAOSISERVICE_BASENAME} ${CARLAOSISERVICE_INSTALL}

  pushd ${CARLAOSISERVICE_INSTALL} >/dev/null

  docker build -t ostar:carla-osi-service .

  popd >/dev/null

  rm -Rf ${CARLAOSISERVICE_BASENAME}.tar.gz
  rm -Rf ${CARLAOSISERVICE_BASENAME}
fi

# ==============================================================================
# -- Download models -----------------------------------------------------------
# ==============================================================================

echo "TODO: Download models."
echo "TODO: Create config for CoSiMa." /ostar_volume/config.yml

# ==============================================================================
# -- Run container -------------------------------------------------------------
# ==============================================================================

#Delete old containers if present
docker rm ostar_carla_osi_service ostar_fmu_1 ostar_cosima || true

docker run -d --network host --name ostar_carla_osi_service ostar:carla-osi-service ./CARLA_OSI_Service &&
docker run -d --network host --name ostar_fmu_1 ostar:osmp ./OSMPService 0.0.0.0:51426

#Wait for all services to start
sleep 2

docker run -d --network host -v `pwd`/ostar_volume:/ostar --name ostar_cosima ostar:cosima ./CoSimulationManager ostar/config.yml

#Run simulation for 30 seconds
sleep 30

# ==============================================================================
# -- Cleanup -------------------------------------------------------------------
# ==============================================================================

docker stop ostar_carla_osi_service ostar_fmu_1 ostar_cosima
#Not removed for inspection purposes. Will be removed at rerun in section "Run container".
