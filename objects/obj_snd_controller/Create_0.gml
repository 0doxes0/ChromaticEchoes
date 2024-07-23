/// @description Insert description here
// You can write your code in this editor
global.current_bgm = snd_happy_bgm;
global.previous_mood = MOOD.VACANT_GREY;

function get_mood_bgm(mood) {
    switch (mood) {
        case MOOD.HAPPY_GREEN:
            return snd_happy_bgm;
        case MOOD.ANGRY_RED:
            return snd_angry_bgm;
        case MOOD.STRESSED_ORANGE:
            return snd_panic_bgm;
        case MOOD.DEPRESSED_BLUE:
            return snd_depressed_bgm;
        case MOOD.PANIC_PURPLE:
            return snd_stressed_bgm;
        default:
            return snd_happy_bgm; // For VACANT_GREY or any undefined mood
    }
}


function start_new_bgm(bgm) {
    global.current_bgm = audio_play_sound(bgm, 10, true);
    audio_sound_gain(global.current_bgm, 0, 0);
    audio_sound_gain(global.current_bgm, 1, 1000); // 1秒内淡入
}

start_new_bgm(snd_happy_bgm);

function update_background_music() {
    var current_mood = obj_player.mood;
    
    // 如果心情改变了
    if (current_mood != global.previous_mood) {
        var new_bgm = get_mood_bgm(current_mood);
        
        // 如果有新的 BGM 要播放
        if (new_bgm != noone) {
            // 如果当前有音乐在播放，先淡出
            if (audio_is_playing(global.current_bgm)) {
                audio_sound_gain(global.current_bgm, 0, 2000); // 2秒内淡出
                alarm[0] = room_speed*2; // 2秒后停止当前音乐并开始新音乐
            } else {
                // 如果当前没有音乐，直接播放新音乐
                start_new_bgm(new_bgm);
            }
        } else if (audio_is_playing(global.current_bgm)) {
            // 如果新的心情没有对应的 BGM（比如 VACANT_GREY），停止当前音乐
            audio_sound_gain(global.current_bgm, 0, 1000);
            alarm[0] = room_speed;
        }
        
        global.previous_mood = current_mood;
    }
}

