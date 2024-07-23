/// @description Insert description here
// You can write your code in this editor
can_proceed = true;

if (is_showing_dialogue) {
    typing_timer += delta_time / 1000000; // ms to s
	
    can_proceed = string_length(displayed_text)>1; // 100毫秒的延迟
	
    if (typing_timer >= typing_speed && curr_char_index < string_length(dialogue_text)) {
        typing_timer = 0; // reset timer
        curr_char_index += 1; 

        // update displayed
        displayed_text = string_copy(dialogue_text, 1, curr_char_index);

        // undate current thread index
        var total_length = 0;
        for (var i = 0; i < array_length(dialog_lines); i++) {
            total_length += string_length(dialog_lines[i][0]);
            if (curr_char_index <= total_length) {
                curr_thread_index = i;
                break;
            }
        }
    }
	
	if ((keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("E"))) && can_proceed) {
        if (curr_char_index < string_length(dialogue_text)) {
            // Finish typing at once if not
            curr_char_index = string_length(dialogue_text);
			curr_thread_index = array_length(dialog_lines)-1;
            displayed_text = dialogue_text;
        }
		else {
			//jump to next dialogue/option
			can_proceed = false;
			dialogue_session += 1;
			if (dialogue_session >= array_length(dialog_threads))
			{
				is_showing_dialogue = false;
				if(has_option){
					is_showing_options = true;
					has_option = false;
				}
				else if(has_next){
					dialogue_selector(next);
				}
			}
			else
			{
				dialog_lines = dialog_threads[dialogue_session];
				reset_dialog_box()
			}
		}
	}
}


if (is_showing_options) {
    if (keyboard_check_pressed(vk_up)) {
        do {
            selected_option -= 1;
            if (selected_option < 0) {
                selected_option = array_length(options) - 1;
            }
        } until (options[selected_option][0][3]); // ignore options whose preconditions were not met
    }
    if (keyboard_check_pressed(vk_down)) {
        do {
            selected_option += 1;
            if (selected_option >= array_length(options)) {
                selected_option = 0;
            }
        } until(options[selected_option][0][3]);  // ignore options whose preconditions were not met
    }
    if ((keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("E"))) && can_proceed) {
        // on chosen
		player_current_health += options[selected_option][0][4][2]  * obj_player.mood_matrix[obj_player.mood][options[selected_option][0][4][0]]
		player_current_health = min(player_max_health, player_current_health)
		effect_mood(options[selected_option][0][4][0], options[selected_option][0][4][1])
		
        var chosen_option = options[selected_option][0][5];
        is_showing_options = false;
		if (chosen_option != -1){
			obj_controller.dialogue_selector(chosen_option);
		}else
			is_showing_dialogue = false
    }
}