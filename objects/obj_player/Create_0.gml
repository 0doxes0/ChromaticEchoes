/// @description Insert description here
// You can write your code in this editor

grid_size = 32;
new_x = x;
new_y = y;
target_x = x;
target_y = y;
move_speed = 4;
is_moving = false;

// for interaction target tracking
enum DIRECTION {
    LEFT,   // 0
    RIGHT,  // 1
    UP,     // 2
    DOWN    // 3
}
_direction = DIRECTION.DOWN

// mood init
enum MOOD {
    VACANT_GREY,      // 0
    HAPPY_GREEN,      // 1
    ANGRY_RED,        // 2
    STRESSED_ORANGE,  // 3
	DEPRESSED_BLUE,   // 4
	PANIC_PURPLE      // 5
}
max_stages[MOOD.VACANT_GREY] = 0
max_stages[MOOD.HAPPY_GREEN] = 4
max_stages[MOOD.ANGRY_RED] = 4
max_stages[MOOD.STRESSED_ORANGE] = 4
max_stages[MOOD.DEPRESSED_BLUE] = 4
max_stages[MOOD.PANIC_PURPLE] = 4

//mood colors init
mood_colors[MOOD.VACANT_GREY][0] = make_color_rgb(175,175,175)

// HAPPY_GREEN
mood_colors[MOOD.HAPPY_GREEN][0] = make_color_rgb(160, 215, 160)
mood_colors[MOOD.HAPPY_GREEN][1] = make_color_rgb(120, 225, 120)
mood_colors[MOOD.HAPPY_GREEN][2] = make_color_rgb(80, 235, 80)
mood_colors[MOOD.HAPPY_GREEN][3] = make_color_rgb(40, 245, 40)
mood_colors[MOOD.HAPPY_GREEN][4] = make_color_rgb(0, 255, 0)

// ANGRY_RED
mood_colors[MOOD.ANGRY_RED][0] = make_color_rgb(215,160,160)
mood_colors[MOOD.ANGRY_RED][1] = make_color_rgb(225,120,120)
mood_colors[MOOD.ANGRY_RED][2] = make_color_rgb(235,80,80)
mood_colors[MOOD.ANGRY_RED][3] = make_color_rgb(245,40,40)
mood_colors[MOOD.ANGRY_RED][4] = make_color_rgb(255,0,0)

// STRESSED_ORANGE
mood_colors[MOOD.STRESSED_ORANGE][0] = make_color_rgb(215, 170, 155)
mood_colors[MOOD.STRESSED_ORANGE][1] = make_color_rgb(225, 160, 115)
mood_colors[MOOD.STRESSED_ORANGE][2] = make_color_rgb(235, 150, 75)
mood_colors[MOOD.STRESSED_ORANGE][3] = make_color_rgb(245, 140, 35)
mood_colors[MOOD.STRESSED_ORANGE][4] = make_color_rgb(255, 125, 0)

// DEPRESSED_BLUE
mood_colors[MOOD.DEPRESSED_BLUE][0] = make_color_rgb(155, 165, 215)
mood_colors[MOOD.DEPRESSED_BLUE][1] = make_color_rgb(120, 135, 225)
mood_colors[MOOD.DEPRESSED_BLUE][2] = make_color_rgb(85, 105, 235)
mood_colors[MOOD.DEPRESSED_BLUE][3] = make_color_rgb(50, 75, 245)
mood_colors[MOOD.DEPRESSED_BLUE][4] = make_color_rgb(20, 50, 255)

// PANIC_PURPLE
mood_colors[MOOD.PANIC_PURPLE][0] = make_color_rgb(175, 155, 180)
mood_colors[MOOD.PANIC_PURPLE][1] = make_color_rgb(175, 115, 185)
mood_colors[MOOD.PANIC_PURPLE][2] = make_color_rgb(175, 75, 190)
mood_colors[MOOD.PANIC_PURPLE][3] = make_color_rgb(175, 35, 195)
mood_colors[MOOD.PANIC_PURPLE][4] = make_color_rgb(175, 0, 205)

mood = MOOD.VACANT_GREY
stage = 0
mood_color = mood_colors[MOOD.VACANT_GREY][0]

// matrix init
enum ATTRIBUTES {
Drain_Rate,
Color_Gain_G,
Color_Gain_R,
Color_Gain_O,
Color_Gain_B,
Color_Gain_P
}


mood_matrix[MOOD.VACANT_GREY][ATTRIBUTES.Drain_Rate] = 1
mood_matrix[MOOD.VACANT_GREY][ATTRIBUTES.Color_Gain_G] = 1
mood_matrix[MOOD.VACANT_GREY][ATTRIBUTES.Color_Gain_R] = 1
mood_matrix[MOOD.VACANT_GREY][ATTRIBUTES.Color_Gain_O] = 1
mood_matrix[MOOD.VACANT_GREY][ATTRIBUTES.Color_Gain_B] = 1
mood_matrix[MOOD.VACANT_GREY][ATTRIBUTES.Color_Gain_P] = 1

mood_matrix[MOOD.ANGRY_RED][ATTRIBUTES.Drain_Rate] = 1.1
mood_matrix[MOOD.ANGRY_RED][ATTRIBUTES.Color_Gain_G] = 1.1
mood_matrix[MOOD.ANGRY_RED][ATTRIBUTES.Color_Gain_R] = 1
mood_matrix[MOOD.ANGRY_RED][ATTRIBUTES.Color_Gain_O] = 0.8
mood_matrix[MOOD.ANGRY_RED][ATTRIBUTES.Color_Gain_B] = 0.8
mood_matrix[MOOD.ANGRY_RED][ATTRIBUTES.Color_Gain_P] = 1

mood_matrix[MOOD.HAPPY_GREEN][ATTRIBUTES.Drain_Rate] = 1.2
mood_matrix[MOOD.HAPPY_GREEN][ATTRIBUTES.Color_Gain_G] = 0.8
mood_matrix[MOOD.HAPPY_GREEN][ATTRIBUTES.Color_Gain_R] = 1.2
mood_matrix[MOOD.HAPPY_GREEN][ATTRIBUTES.Color_Gain_O] = 1.2
mood_matrix[MOOD.HAPPY_GREEN][ATTRIBUTES.Color_Gain_B] = 1
mood_matrix[MOOD.HAPPY_GREEN][ATTRIBUTES.Color_Gain_P] = 0.8

mood_matrix[MOOD.STRESSED_ORANGE][ATTRIBUTES.Drain_Rate] = 1
mood_matrix[MOOD.STRESSED_ORANGE][ATTRIBUTES.Color_Gain_G] = 0.8
mood_matrix[MOOD.STRESSED_ORANGE][ATTRIBUTES.Color_Gain_R] = 1.2
mood_matrix[MOOD.STRESSED_ORANGE][ATTRIBUTES.Color_Gain_O] = 1
mood_matrix[MOOD.STRESSED_ORANGE][ATTRIBUTES.Color_Gain_B] = 1.2
mood_matrix[MOOD.STRESSED_ORANGE][ATTRIBUTES.Color_Gain_P] = 1.2

mood_matrix[MOOD.DEPRESSED_BLUE][ATTRIBUTES.Drain_Rate] = 1.2
mood_matrix[MOOD.DEPRESSED_BLUE][ATTRIBUTES.Color_Gain_G] = 0.8
mood_matrix[MOOD.DEPRESSED_BLUE][ATTRIBUTES.Color_Gain_R] = 0.8
mood_matrix[MOOD.DEPRESSED_BLUE][ATTRIBUTES.Color_Gain_O] = 0.5
mood_matrix[MOOD.DEPRESSED_BLUE][ATTRIBUTES.Color_Gain_B] = 1
mood_matrix[MOOD.DEPRESSED_BLUE][ATTRIBUTES.Color_Gain_P] = 0.5

mood_matrix[MOOD.PANIC_PURPLE][ATTRIBUTES.Drain_Rate] = 1
mood_matrix[MOOD.PANIC_PURPLE][ATTRIBUTES.Color_Gain_G] = 1
mood_matrix[MOOD.PANIC_PURPLE][ATTRIBUTES.Color_Gain_R] = 0.8
mood_matrix[MOOD.PANIC_PURPLE][ATTRIBUTES.Color_Gain_O] = 1
mood_matrix[MOOD.PANIC_PURPLE][ATTRIBUTES.Color_Gain_B] = 1
mood_matrix[MOOD.PANIC_PURPLE][ATTRIBUTES.Color_Gain_P] = 1.2