# Supported OSI fields in CARLA OSI Service

## Filled fields in OSI3 SensorView

* sensor_view.sensor_id
<!-- * sensor_view.mounting_position-->
* sensor_view.global_ground_truth.timestamp
* sensor_view.global_ground_truth.host_vehicle_id
* sensor_view.global_ground_truth.stationary_object.id
* sensor_view.global_ground_truth.stationary_object.base.dimension
* sensor_view.global_ground_truth.stationary_object.base.position
* sensor_view.global_ground_truth.stationary_object.base.orientation
* sensor_view.global_ground_truth.stationary_object.classification.type
* sensor_view.global_ground_truth.stationary_object.model_reference
* sensor_view.global_ground_truth.moving_object.id
* sensor_view.global_ground_truth.moving_object.base.position
* sensor_view.global_ground_truth.moving_object.base.orientation
* sensor_view.global_ground_truth.moving_object.base.orientation_rate
* sensor_view.global_ground_truth.moving_object.base.velocity
* sensor_view.global_ground_truth.moving_object.base.acceleration
* sensor_view.global_ground_truth.moving_object.base.dimension
* sensor_view.global_ground_truth.moving_object.type
* sensor_view.global_ground_truth.moving_object.assigned_lane_id
* sensor_view.global_ground_truth.moving_object.vehicle_attributes.radius_wheel
* sensor_view.global_ground_truth.moving_object.vehicle_attributes.number_wheels
* sensor_view.global_ground_truth.moving_object.vehicle_attributes.bbcenter_to_rear
* sensor_view.global_ground_truth.moving_object.vehicle_attributes.bbcenter_to_front
* sensor_view.global_ground_truth.moving_object.vehicle_attributes.ground_clearance
* sensor_view.global_ground_truth.moving_object.vehicle_classification.type
* sensor_view.global_ground_truth.moving_object.vehicle_classification.light_state
* sensor_view.global_ground_truth.moving_object.vehicle_classification.has_trailer
* sensor_view.global_ground_truth.moving_object.model_reference
* sensor_view.global_ground_truth.traffic_sign.id
* sensor_view.global_ground_truth.traffic_sign.main_sign.base.dimension
* sensor_view.global_ground_truth.traffic_sign.main_sign.base.position
* sensor_view.global_ground_truth.traffic_sign.main_sign.base.orientation
* sensor_view.global_ground_truth.traffic_sign.main_sign.classification.direction_scope
* sensor_view.global_ground_truth.traffic_sign.main_sign.classification.variability
* sensor_view.global_ground_truth.traffic_sign.main_sign.classification.value

Additional fields with option --mapnetwork:
* sensor_view.global_ground_truth.lane.id
* sensor_view.global_ground_truth.lane.classification.type
* sensor_view.global_ground_truth.lane.classification.lane_pairing
* sensor_view.global_ground_truth.lane.classification.centerline
* sensor_view.global_ground_truth.lane.classification.left_adjacent_lane_id
* sensor_view.global_ground_truth.lane.classification.right_adjacent_lane_id
* sensor_view.global_ground_truth.lane_boundary.left_lane_boundary_id
* sensor_view.global_ground_truth.lane_boundary.right_lane_boundary_id

Additional fields with camera sensor:
* sensor_view.camera_sensor_view.view_configuration.sensor_id
* sensor_view.camera_sensor_view.view_configuration.mounting_position
* sensor_view.camera_sensor_view.view_configuration.field_of_view_horizontal
* sensor_view.camera_sensor_view.view_configuration.field_of_view_vertical
* sensor_view.camera_sensor_view.view_configuration.number_of_pixels_horizontal
* sensor_view.camera_sensor_view.view_configuration.set_number_of_pixels_vertical
* sensor_view.camera_sensor_view.view_configuration.channel_format (only CHANNEL_FORMAT_RGB_U8_LIN)
* sensor_view.camera_sensor_view.image_data

Additional fields with lidar sensor:
* sensor_view.lidar_sensor_view.view_configuration.sensor_id
* sensor_view.lidar_sensor_view.view_configuration.mounting_position
* sensor_view.lidar_sensor_view.view_configuration.field_of_view_horizontal
* sensor_view.lidar_sensor_view.view_configuration.field_of_view_vertical
* sensor_view.lidar_sensor_view.view_configuration.number_of_rays_horizontal
* sensor_view.lidar_sensor_view.view_configuration.number_of_rays_vertical
* sensor_view.lidar_sensor_view.view_configuration.max_number_of_interactions
* sensor_view.lidar_sensor_view.view_configuration.num_of_pixels
* sensor_view.lidar_sensor_view.view_configuration.emitter_frequency
* sensor_view.lidar_sensor_view.reflection
* sensor_view.lidar_sensor_view.reflection.signal_strength
* sensor_view.lidar_sensor_view.reflection.time_of_flight (simple model)
* sensor_view.lidar_sensor_view.reflection.normal_to_surface

Additional fields with radar sensor:
* sensor_view.radar_sensor_view.view_configuration.sensor_id
* sensor_view.radar_sensor_view.view_configuration.mounting_position
* sensor_view.radar_sensor_view.view_configuration.field_of_view_horizontal
* sensor_view.radar_sensor_view.view_configuration.field_of_view_vertical
* sensor_view.radar_sensor_view.view_configuration.number_of_rays_horizontal
* sensor_view.radar_sensor_view.view_configuration.number_of_rays_vertical
* sensor_view.radar_sensor_view.view_configuration.max_number_of_interactions (1)
* sensor_view.radar_sensor_view.view_configuration.emitter_frequency
* sensor_view.radar_sensor_view.reflection
* sensor_view.radar_sensor_view.reflection.horizontal_angle
* sensor_view.radar_sensor_view.reflection.vertical_angle
* sensor_view.radar_sensor_view.reflection.time_of_flight (simple model)
* sensor_view.radar_sensor_view.reflection.signal_strenght (simple model)

### Interpreted Fields in OSI3 TrafficUpdate

* traffic_update.update.id
* traffic_update.update.model_reference
* traffic_update.update.base.dimension
* traffic_update.update.base.position
* traffic_update.update.base.orientation
* traffic_update.update.base.velocity
* traffic_update.update.base.orientation_rate
* traffic_update.update.vehicle_classification.light_state
