/// @description Insert description here
// You can write your code in this editor

// Camera set up
enum RES{
	WIDTH = 640,
	HEIGHT = 360,
	SCALE = 4
}

var _camera = camera_create_view(0,0, RES.WIDTH, RES.HEIGHT, 0, obj_player, -1, -1, RES.WIDTH/2, RES.HEIGHT/2)

view_enabled = true;
view_visible[0] = true;

view_set_camera(0,_camera)

// basic dialog
is_showing_dialogue = false;
text_scale = 2;
dialogue_text = ".";
dialogue_id = 0;
dialogue_session = 0;

// typing animation
displayed_text = ""; // current text at display
typing_speed = 0.025; // second/chara
typing_timer = 0; 
curr_char_index = 0;

// threading
dialog_threads = []
dialog_lines[0][0] = "Dialog is empty."
dialog_lines[0][1] = c_white
dialog_lines[0][2] = false // shaking

curr_thread_index = 0;
// Create选项数据结构
options = [];
selected_option = 0;
has_option = false;
is_showing_options = false;

// 示例选项数据
options[0] = [
    ["Option 1: ", c_white, false],
    ["Do something", c_white, true]
];
options[0][0][3] = true
options[1] = [
    ["Option 2: ", c_white, false],
    ["Do something else", c_white, false]
];
options[1][0][3] = true
options[2] = [
    ["Option 3: ", c_white, false],
    ["Another option", c_white, true]
];
options[2][0][3] = true



flag_is_delivering = false;

function show_dialogue(_id){
	switch _id{
	case 1:
		dialog_threads = [[
			["My ", c_white, false], 
			["wife", c_white, true], 
			[" is going to church.", c_white, false]
		],
		[
			["Hey, haven't seen you in a while. ", c_white, false],
			["How you doing? ", c_white, false]],[
			["Look at this ", c_red, false],
			["shaking", c_red, true],
			[" word!", c_red, false]
		],
		[["Sorry, work's been pretty rough. You're always welcome to swing by my place anytime, however. ", c_white, false]]
		]
		break;
	case 2:
		dialog_threads =[[
				["Hi. The delivery people left my books out here on the sidewalk. Can you help me bring them in? ", c_white, false]
			]]
		has_option = true
		options[0] = [
			["Of course.", c_white, false]
		];
		options[0][0][3] = !flag_is_delivering; // condition
		options[0][0][4] = [MOOD.HAPPY_GREEN,2]; // effective mood color and extent
		options[0][0][5] = 201; // result id, any number bigger than 100 and not used
		options[1] = [
			["Sorry, don't think I can lift much right now. ", c_white, false]
		];
		options[1][0][3] = flag_is_delivering;
		options[1][0][4] = [MOOD.DEPRESSED_BLUE_1,1];
		options[1][0][5] = 202;
		options[2] = [
			["Sorry, don't have the time right now. ", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.STRESSED_ORANGE,1];
		options[2][0][5] = 203;
		break;
	case 201:
	flag_is_delivering = true; // effect other than mood
	dialog_threads =[[
				["Thank you!", c_white, false]
			]]
		break;
	case 202:
	dialog_threads =[[
				["Oh, I'm sorry to hear that.", c_white, false]
			]]
		break;
	case 203:
	dialog_threads =[[
				["Oh, I understand. ", c_white, false]
			]]
		break;
	case -1:
			dialog_threads =[[
				["Now this is a loooooooooooooooooong example to show you the auto line switch. ", c_white, false],
				["It also has ", c_white, false],
				["colored", c_blue, false],
				[" and ", c_white, false],
				["shaking", c_red, true],
				[" text.", c_white, false]
			]]
		break;
	case 4:
		break;
	default:
		is_showing_dialogue = false;
	}
}