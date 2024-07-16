/// @description Insert description here
// You can write your code in this editor
// 初始化粒子系统
snow_system = part_system_create();
part_system_depth(snow_system, -2000); // 确保雪花在前景

// 创建雪花粒子类型
snow_particle = part_type_create();
part_type_sprite(snow_particle, spr_snowflake, false, false, true);
part_type_size(snow_particle, 0.1, 0.3, 0, 0);
part_type_scale(snow_particle, 1, 1);
part_type_speed(snow_particle, 1, 2, -0.01, 0);
part_type_direction(snow_particle, 250, 290, 0, 2);
part_type_gravity(snow_particle, 0.01, 270);
part_type_life(snow_particle, room_speed * 4, room_speed * 6);
part_type_alpha3(snow_particle, 0, 0.6, 0);

// 创建发射器
snow_emitter = part_emitter_create(snow_system);
part_emitter_region(snow_system, snow_emitter, 0, room_width, -10, 0, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(snow_system, snow_emitter, snow_particle, -5);