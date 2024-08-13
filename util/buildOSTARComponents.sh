#!/bin/bash
docker build -f dockerfiles/Dockerfile4OstarCore -t ostar:core_builder .

check_commit() {
  local commit=$1
  current_commit=$(git rev-parse HEAD)
  if [ "$current_commit" == "$commit" ]; then
    echo "Correct commit checked out"
    #With local changes, build it manually with the corresponding image name.
    return 0
  else
    echo "Wrong commit"
    return 1
  fi
}

check_image() {
  local image_name=$1
  if docker images --format '{{.Repository}}:{{.Tag}}' | grep -Eq "^${image_name}$"; then
    echo "Image exist: $image_name"
    return 0
  else
    echo "Image does not exist: $image_name"
    return 1
  fi
}

OSTAR_DIR=../OSTAR

# ==============================================================================
# -- Get and compile OSMP-Service ----------------------------------------------
# ==============================================================================

OSMPSERVICE_VERSION=c5310e54394fbc2c6aa89934ec0c9bf674b1a4c5
OSMPSERVICE_REPO=https://github.com/DLR-TS/OSMP-Service.git
OSMPSERVICE_INSTALL=OSMP-Service
OSMPSERVICE_IMAGE_NAME=ostar:osmpservice-18
OMSPSERVICE_BUILD=true

echo "Build OSTAR component ${OSMPSERVICE_INSTALL} from DLR-TS (German Aerospace Center Institute of Transportation Systems)"

if [[ -d ${OSTAR_DIR}/${OSMPSERVICE_INSTALL} ]] ; then
  pushd ${OSTAR_DIR}/${OSMPSERVICE_INSTALL} >/dev/null

  check_commit $OSMPSERVICE_VERSION
  commit_status=$?
  popd >/dev/null

  check_image $OSMPSERVICE_IMAGE_NAME
  image_status=$?
  if [[ "$commit_status" -eq 0 ]] && [[ "$image_status" -eq 0 ]]; then
    echo "Skip build of OSMP-Service"
    OMSPSERVICE_BUILD=false
  else
    echo "Remove old version of OSMP-Service."
    rm -rf ${OSTAR_DIR}/${OSMPSERVICE_INSTALL}
  fi
fi

if $OMSPSERVICE_BUILD; then
  echo "Retrieving OSMP-Service."
  pushd ${OSTAR_DIR} > /dev/null
  git clone ${OSMPSERVICE_REPO}

  popd >/dev/null
  pushd ${OSTAR_DIR}/${OSMPSERVICE_INSTALL} >/dev/null

  git checkout ${OSMPSERVICE_VERSION}
  docker build -f Dockerfile18 -t $OSMPSERVICE_IMAGE_NAME .

  popd >/dev/null
fi

# ==============================================================================
# -- Get and compile Cosima ----------------------------------------------------
# ==============================================================================

COSIMA_VERSION=612c60a785f61c05065b55a3bf4e404e7c849e1d
COSIMA_REPO=https://github.com/DLR-TS/CoSiMa.git
COSIMA_INSTALL=CoSiMa
COSIMA_IMAGE_NAME=ostar:cosima-18
COSIMA_BUILD=true

echo "Build OSTAR component ${COSIMA_INSTALL} from DLR-TS (German Aerospace Center Institute of Transportation Systems)"

if [[ -d ${OSTAR_DIR}/${COSIMA_INSTALL} ]] ; then
  pushd ${OSTAR_DIR}/${COSIMA_INSTALL} >/dev/null

  check_commit $COSIMA_VERSION
  commit_status=$?
  popd >/dev/null

  check_image $COSIMA_IMAGE_NAME
  image_status=$?
  if [[ "$commit_status" -eq 0 ]] && [[ "$image_status" -eq 0 ]]; then
    echo "Skip build of CoSiMa"
    COSIMA_BUILD=false
  else
    echo "Remove old version of CoSiMa."
    rm -rf ${OSTAR_DIR}/${COSIMA_INSTALL}
  fi
fi

if $COSIMA_BUILD; then
  echo "Retrieving CoSiMa."
  pushd ${OSTAR_DIR} > /dev/null
  git clone ${COSIMA_REPO}

  popd >/dev/null
  pushd ${OSTAR_DIR}/${COSIMA_INSTALL} >/dev/null

  git checkout ${COSIMA_VERSION}
  docker build -f Dockerfile18 -t $COSIMA_IMAGE_NAME .

  popd >/dev/null
fi

# ==============================================================================
# -- Get and compile Carla-OSI-Service -----------------------------------------
# ==============================================================================

CARLAOSISERVICE_VERSION=5257cc0f81eb5f22dbd8d5bb62d0b3f4e9ed7122
CARLAOSISERVICE_REPO=https://github.com/DLR-TS/Carla-OSI-Service.git
CARLAOSISERVICE_INSTALL=Carla-OSI-Service
CARLAOSISERVICE_IMAGE_NAME=ostar:carla-osi-service-18
CARLAOSISERVICE_BUILD=true

echo "Build OSTAR component ${CARLAOSISERVICE_INSTALL} from DLR-TS (German Aerospace Center Institute of Transportation Systems)"

if [[ -d ${OSTAR_DIR}/${CARLAOSISERVICE_INSTALL} ]] ; then
  pushd ${OSTAR_DIR}/${CARLAOSISERVICE_INSTALL} >/dev/null

  check_commit $CARLAOSISERVICE_VERSION
  commit_status=$?
  popd >/dev/null

  check_image $CARLAOSISERVICE_IMAGE_NAME
  image_status=$?
  if [[ "$commit_status" -eq 0 ]] && [[ "$image_status" -eq 0 ]]; then
    echo "Skip build of Carla-OSI-Service"
    CARLAOSISERVICE_BUILD=false
  else
    echo "Remove old version of Carla-OSI-Service."
    rm -rf ${OSTAR_DIR}/${CARLAOSISERVICE_INSTALL}
  fi
fi

if $CARLAOSISERVICE_BUILD; then
  echo "Retrieving Carla-OSI-Service."
  pushd ${OSTAR_DIR} > /dev/null
  git clone ${CARLAOSISERVICE_REPO}

  popd >/dev/null
  pushd ${OSTAR_DIR}/${CARLAOSISERVICE_INSTALL} >/dev/null

  git checkout ${CARLAOSISERVICE_VERSION}
  docker build -f Dockerfile18 -t $CARLAOSISERVICE_IMAGE_NAME .

  popd >/dev/null
fi
