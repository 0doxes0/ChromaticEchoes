/// @description Insert description here
// You can write your code in this editor

// a method that would draw the text shaking
function draw_shaking_text(x, y, _text, _xscale, _yscale, _rotation) {
    var _shake_strength = 2;
    var _shake_x = irandom_range(-_shake_strength, _shake_strength);
    var _shake_y = irandom_range(-_shake_strength, _shake_strength);
    draw_text_transformed(x + _shake_x, y + _shake_y, _text, _xscale, _yscale, _rotation);
}

// invoke a particular line in a particular dialogue
function dialogue_selector(_id){
	dialogue_id = _id;
	dialogue_session = 0;
	show_dialogue(dialogue_id);
	dialog_lines = dialog_threads[0];
	reset_dialog_box();
	is_showing_dialogue = true;
}

function reset_dialog_box(){
	dialogue_text =　"";
	for(var i = 0; i < array_length(dialog_lines); i++)
		dialogue_text += dialog_lines[i][0];
	displayed_text = "";
	typing_timer = 0;
	curr_char_index = 0;
	curr_thread_index = 0;
}

// hp bar background
draw_set_color(c_black);
draw_rectangle(health_bar_x, health_bar_y, health_bar_x + health_bar_width, health_bar_y + health_bar_height, false);

var health_ratio = player_current_health / player_max_health;
var current_health_bar_width = health_bar_width * health_ratio;

// lerp hp bar from green to red
var health_color = make_color_rgb(lerp(255, 0, health_ratio), lerp(0, 255, health_ratio), 0);

// hp bar flashing
flash_timer += delta_time / 1000000 * flash_speed;
var flash_alpha = health_ratio > 1/3 ? 0: 3*(1/3-health_ratio); // flashes when hp goes below 1/3
var alpha = 0.5 + 0.5 * sin(flash_timer) * flash_alpha;

// draw hp bar
draw_set_color(merge_color(health_color, make_color_rgb(0, 0, 0), 1 - alpha));
draw_rectangle(health_bar_x, health_bar_y, health_bar_x + current_health_bar_width, health_bar_y + health_bar_height, false);
// draw edges
draw_set_color(c_white);
draw_rectangle(health_bar_x, health_bar_y, health_bar_x + health_bar_width, health_bar_y + health_bar_height, true);


if(is_showing_dialogue){
	draw_sprite(spr_text_box, 0, 0, 568)
	
	var dialogue_x = 40;
    var dialogue_y = display_get_gui_height() - 180;
    var dialogue_width = display_get_gui_width();
    var dialogue_height = 100;
	var line_height = 20 * text_scale;

    // draw lines in successive order
    var draw_x = dialogue_x + 10;
    var draw_y = dialogue_y + 10;
    var current_length = 0;

    for (var _i = 0; _i <= curr_thread_index; _i++) {
        var text_part = dialog_lines[_i][0];
        var color = dialog_lines[_i][1];
        var shake = dialog_lines[_i][2];

        // current part's length
        current_length += string_length(text_part);

        // check to which index it is typing and cut the rest
        if (current_length > curr_char_index) {
            text_part = string_copy(text_part, 1, string_length(text_part) - (current_length - curr_char_index));
        }
		
		
        var text_width = string_width(text_part) * text_scale;
		if(text_width < dialogue_width/3){
			//short exceeding message will turn to the next line
			if (draw_x + text_width > dialogue_x + dialogue_width - 30) {
				draw_x = dialogue_x + 10;
				draw_y += line_height;
				if (draw_y >= dialogue_y + dialogue_height - 10) {
					break; // height limit break
				}
			}
		}else // long exceeding message will split into two
        if (draw_x + text_width > dialogue_x + dialogue_width - 30) {
            var last_space_index = 0;
            for (var j = 1; j <= string_length(text_part); j++) {
                if string_char_at(text_part, j) == " " {
                    last_space_index = j;
                }

                if (draw_x + string_width(string_copy(text_part, 1, j)) * text_scale > dialogue_x + dialogue_width - 30) {
                    if (last_space_index == 0) {
                        // no space can be found in the long message, proceeding to hard break
                        var split_index = j - 1;
                    } else {
                        var split_index = last_space_index;
                    }
                    var first_part = string_copy(text_part, 1, split_index);
                    var second_part = string_copy(text_part, split_index + 1, string_length(text_part) - split_index);
                    
                    // draw first part of the text
                    draw_set_color(color);
                    if (shake) {
                        draw_shaking_text(draw_x, draw_y, first_part, text_scale, text_scale, 0);
                    } else {
                        draw_text_transformed(draw_x, draw_y, first_part, text_scale, text_scale, 0);
                    }

                    // Update drawing position to the next line
                    draw_x = dialogue_x + 10;
                    draw_y += line_height;

                    // draw second part of the text
                    text_part = second_part;
                    j = 0;
                    last_space_index = 0;

                    if (draw_y >= dialogue_y + dialogue_height - 10) {
                        break;// height limit break
                    }
                }
            }
        }

        draw_set_color(color);

        if (shake) {
            draw_shaking_text(draw_x, draw_y, text_part, text_scale, text_scale, 0);
        } else {
            draw_text_transformed(draw_x, draw_y, text_part, text_scale, text_scale, 0);
        }

        draw_x += string_width(text_part) * text_scale;
    }
}



if (is_showing_options) {
    var option_x = 40;
    var option_y = display_get_gui_height() - 180;
    var option_width = display_get_gui_width() - 80;
    var option_height = 100;
    var line_height = 20 * text_scale;

    draw_sprite(spr_text_box, 0, 0, 568);

    var draw_x = option_x + 10;
    var draw_y = option_y + 10;

    for (var i = 0; i < array_length(options); i++) {
        if (options[i][0][3]) { // precondition check, if false, option will not appear
            // highlighter
            if (i == selected_option) {
                draw_sprite_stretched(spr_highlight_box, 0, draw_x - 40, draw_y , option_width+40, option_height/2); // 高亮边框精灵
            }

            for (var j = 0; j < array_length(options[i]); j++) {
                var text_part = options[i][j][0];
                var color = options[i][j][1];
                var shake = options[i][j][2];

                draw_set_color(color);
                if (shake) {
                    draw_shaking_text(draw_x, draw_y, text_part, text_scale, text_scale, 0);
                } else {
                    draw_text_transformed(draw_x, draw_y, text_part, text_scale, text_scale, 0);
                }
                
                draw_x += string_width(text_part) * text_scale;

                //// option line switch?
                //var text_width = string_width(text_part) * text_scale;
                //if (draw_x + text_width > option_x + option_width - 30) {
                //    draw_x = option_x + 10;
                //    draw_y += line_height;
                //}
            }
            draw_x = option_x + 10; // reset
            draw_y += line_height; // next line
        }
    }
}