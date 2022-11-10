#!/bin/bash
#Run demo of OSTAR

# ==============================================================================
# -- Run container -------------------------------------------------------------
# ==============================================================================

OSMPMODEL_DIR=OSMPDummy

#Delete old containers if present
docker rm ostar_carla_osi_service ostar_dummy_fmu ostar_cosima || true

docker run -d --network host --name ostar_carla_osi_service ostar:carla-osi-service /carlaosiservice/build/bin/CARLA_OSI_Service -resumeAfter 5 -log /logs/log.csv &&
docker run -d -p 51426:51425 --name ostar_dummy_fmu ostar:osmpservice OSMPService

#Wait for all services to start
sleep 2

docker run -d --network host -v `pwd`/${OSMPMODEL_DIR}:/ostar --name ostar_cosima ostar:cosima ./CoSimulationManager -v ostar/config.yml

#Run simulation as a test for 30 seconds.
sleep 30

# ==============================================================================
# -- Cleanup -------------------------------------------------------------------
# ==============================================================================

docker stop ostar_cosima ostar_dummy_fmu

sleep 10 #Wait for Carla OSI Service to resume Carla

docker stop ostar_carla_osi_service
#Not removed for inspection purposes. Will be removed at rerun in section "Run container".

echo "Done. See docker logs with:"
echo "docker logs <ostar_cosima, ostar_carla_osi_service, ostar_dummy_fmu>"

