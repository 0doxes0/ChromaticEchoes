/// @description Insert description here
// You can write your code in this editor

if(!is_moving && !obj_controller.is_showing_dialogue){
	if (random(1) < 0.01) { // 10%的几率移动
		var dir = irandom(3); // 0:上, 1:右, 2:下, 3:左
		var move_x = 0;
		var move_y = 0;
    
		switch(dir) {
			case 0: move_y = -1; break;
			case 1: move_x = 1; break;
			case 2: move_y = 1; break;
			case 3: move_x = -1; break;
		}
    
		new_x = x + move_x * grid_size;
		new_y = y + move_y * grid_size;
    
		// 检查是否在允许的范围内且没有碰撞
		if (abs(new_x - start_x) > move_range * grid_size or
			abs(new_y - start_y) > move_range * grid_size or
			place_meeting(new_x, new_y, obj_solid_parent)) {
			new_x = x;
			new_y = y;
		}
	}
}




if (x != new_x || y != new_y) {
	is_moving = true;
	
	if (x < new_x) {
		x += move_speed;
		if (x > new_x) x = new_x;
	}
	else if (x > new_x) {
		x -= move_speed;
		if (x < new_x) x = new_x;
	}
	else if (y < new_y) {
		y += move_speed;
		if (y > new_y) y = new_y;
	}
	else if (y > new_y) {
		y -= move_speed;
		if (y < new_y) y = new_y;
	}	
}
else if(is_moving){
	is_moving = false;
}