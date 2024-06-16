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
    VACANT_GREY_0,      // 0
    HAPPY_GREEN,      // 1
    ANGRY_RED_4,        // 2
    STRESSED_ORANGE,  // 3
	DEPRESSED_BLUE_1,   // 4
	PANIC_PURPLE      // 5
}
max_stages[MOOD.VACANT_GREY_0] = 0
max_stages[MOOD.ANGRY_RED_4] = 4
max_stages[MOOD.DEPRESSED_BLUE_1] = 1
//max_stages[MOOD.VACANT_GREY_0] = 0
//max_stages[MOOD.VACANT_GREY_0] = 0
//max_stages[MOOD.VACANT_GREY_0] = 0

//mood colors init
mood_colors[MOOD.VACANT_GREY_0][0] = make_color_rgb(175,175,175)
mood_colors[MOOD.ANGRY_RED_4][0] = make_color_rgb(215,160,160)
mood_colors[MOOD.ANGRY_RED_4][1] = make_color_rgb(225,120,120)
mood_colors[MOOD.ANGRY_RED_4][2] = make_color_rgb(235,80,80)
mood_colors[MOOD.ANGRY_RED_4][3] = make_color_rgb(245,40,40)
mood_colors[MOOD.ANGRY_RED_4][4] = make_color_rgb(255,0,0)
mood_colors[MOOD.DEPRESSED_BLUE_1][0] = make_color_rgb(75,100,225)
mood_colors[MOOD.DEPRESSED_BLUE_1][1] = make_color_rgb(20,50,255)
mood = MOOD.VACANT_GREY_0
stage = 0
mood_color = mood_colors[MOOD.VACANT_GREY_0][0]

// matrix init
enum ATTRIBUTES {
Max_Fill,
Drain_Rate,
Positive_Bonus,
Negative_Effect,
Movement,
Color_Gain_G,
Color_Gain_R,
Color_Gain_O,
Color_Gain_B,
Color_Gain_P
}