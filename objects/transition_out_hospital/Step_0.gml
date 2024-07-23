/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x, y, obj_player)) {
	room_goto(Room1);
	obj_player.x = 224;
	obj_player.y = 288;
	obj_player.target_x = 224;
	obj_player.target_y = 288;
	obj_player.new_x = 224;
	obj_player.new_y = 288;
}