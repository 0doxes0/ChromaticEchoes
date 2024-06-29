// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function effect_mood(_mood, _degree){
	if (instance_exists(obj_player)) {
		
		if(_mood == obj_player.mood){
			obj_player.stage += _degree;
		}
		else{
			obj_player.stage -= _degree;
			if (obj_player.stage < 0) {
				obj_player.stage = - obj_player.stage - 1;
				obj_player.mood = _mood;
			}
		}
		obj_player.stage = min(obj_player.max_stages[ obj_player.mood], obj_player.stage)
		
		obj_player.mood_color = obj_player.mood_colors[obj_player.mood][obj_player.stage];
	}
}