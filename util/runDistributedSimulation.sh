#!/bin/bash
#Run demo of OSTAR

# ==============================================================================
# -- Run container -------------------------------------------------------------
# ==============================================================================

#Delete old containers if present
if docker ps -a | grep "ostar_carla_osi_service"; then
	docker rm ostar_carla_osi_service || true
fi
if docker ps -a | grep "ostar_osmpservice_1"; then
	docker rm ostar_osmpservice_1 || true
fi
if docker ps -a | grep "ostar_osmpservice_2"; then
	docker rm ostar_osmpservice_2 || true
fi
if docker ps -a | grep "ostar_cosima"; then
	docker rm ostar_cosima || true
fi

docker run -d --network host --name ostar_carla_osi_service ostar:carla-osi-service-18 /carlaosiservice/build/bin/CARLA_OSI_Service -resumeAfter 5 -log /logs/log.csv &&
docker run -d -p 51426:51425 --name ostar_osmpservice-18 ostar:osmpservice OSMPService
docker run -d -p 51427:51425 --name ostar_osmpservice-18 ostar:osmpservice OSMPService

#Wait for all services to start
sleep 2

config_abs_path=$(realpath .)

#Option: The model volume can also be mounted by the OSMPServices
docker run -d --network host -v $config_abs_path/examples/08-distributed:/ostar -v $config_abs_path/models/fmu:/models --name ostar_cosima ostar:cosima-18 ./CoSimulationManager -v ostar/configDistributedSimulation.yml

#Run simulation as a test for 30 seconds.
sleep 30

# ==============================================================================
# -- Cleanup -------------------------------------------------------------------
# ==============================================================================

docker stop ostar_cosima ostar_osmpservice_1 ostar_osmpservice_2

sleep 10 #Wait for Carla OSI Service to resume Carla

docker stop ostar_carla_osi_service
#Not removed for inspection purposes. Will be removed at rerun in section "Run container".

echo "Done. See docker logs with:"
echo "docker logs <ostar_cosima, ostar_carla_osi_service, ostar_osmpservice_1, ostar_osmpservice_2>"
echo "Inspect simulation output files in osmpservice container with:"
echo "docker start ostar_osmpservice_2"
echo "docker exec -it ostar_osmpservice_2 bash"

