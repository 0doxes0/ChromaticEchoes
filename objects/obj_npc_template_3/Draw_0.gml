/// @description Insert description here
// You can write your code in this editor
if(!conversed){
	draw_sprite(spr_bubble_special, frame, x+5, y-22)
}

frame += animation_speed;

if (frame >= sprite_get_number(spr_bubble)) {
    frame = 0;
}
draw_self()