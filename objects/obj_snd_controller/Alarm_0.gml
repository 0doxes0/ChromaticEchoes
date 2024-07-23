/// @description Insert description here
// You can write your code in this editor

if (alarm[0] == 0) {
    if (audio_is_playing(global.current_bgm)) {
        audio_stop_sound(global.current_bgm);
    }
    var new_bgm = get_mood_bgm(obj_player.mood);
    if (new_bgm != noone) {
        start_new_bgm(new_bgm);
    }
}