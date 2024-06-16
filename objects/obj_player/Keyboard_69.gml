/// @description Insert description here
// You can write your code in this editor

if(!obj_controller.is_showing_dialogue && !obj_controller.is_showing_options){
    if (_direction == DIRECTION.LEFT) {
        new_x -= grid_size;
    }
    else if (_direction == DIRECTION.RIGHT) {
        new_x += grid_size;
    }
    else if (_direction == DIRECTION.UP) {
        new_y -= grid_size;
    }
    else if (_direction == DIRECTION.DOWN) {
        new_y += grid_size;
    }

    var _obj = instance_position(new_x, new_y, obj_solid_parent);
    if (_obj != noone) {
        with (_obj) {
            event_user(0);
        }
    }else {
		new_x = x;
		new_y = y;
        show_message("No object found at target position");
    }
}