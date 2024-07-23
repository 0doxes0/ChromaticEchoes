/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x, y, obj_player)) {
	room_goto(rm_hospital);
	obj_player.x = 278;
	obj_player.y = 496;
	obj_player.target_x = 278;
	obj_player.target_y = 496;
	obj_player.new_x = 278;
	obj_player.new_y = 496;
}