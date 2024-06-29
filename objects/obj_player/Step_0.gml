/// @description Insert description here
// You can write your code in this editor

if (!is_moving && !obj_controller.is_showing_dialogue&& !obj_controller.is_showing_options) {

    if (keyboard_check_pressed(vk_left)) {
        new_x -= grid_size;
        _direction = DIRECTION.LEFT
    }
    else if (keyboard_check_pressed(vk_right)) {
        new_x += grid_size;
        _direction = DIRECTION.RIGHT;
    }
    else if (keyboard_check_pressed(vk_up)) {
        new_y -= grid_size;
        _direction = DIRECTION.UP;
    }
    else if (keyboard_check_pressed(vk_down)) {
        new_y += grid_size;
        _direction = DIRECTION.DOWN;
    }

    if (!place_meeting(new_x, new_y, obj_solid_parent)) {
        target_x = new_x;
        target_y = new_y;
    } else {
        new_x = x;
        new_y = y;
    }
}


if (x < target_x) {
    x += move_speed;
    if (x > target_x) x = target_x;
}
else if (x > target_x) {
    x -= move_speed;
    if (x < target_x) x = target_x;
}
else if (y < target_y) {
    y += move_speed;
    if (y > target_y) y = target_y;
}
else if (y > target_y) {
    y -= move_speed;
    if (y < target_y) y = target_y;
}	

if (x != target_x || y != target_y) {
	is_moving = true;
}
else if(is_moving){
	if (obj_controller.player_current_health > 0) {
		obj_controller.player_current_health -= 1*mood_matrix[mood][ATTRIBUTES.Drain_Rate];
	}
	is_moving = false;
}
	


var _trail = instance_create_layer(x, y, "Instances", obj_trail);
_trail.image_blend = mood_color;


