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

// player energy
player_max_health = 100;
player_current_health = 100;
health_bar_width = display_get_gui_width() - 60;
health_bar_height = 20;
health_bar_x = 10;
health_bar_y = 10;
flash_timer = 0;
flash_speed = 5; // frequency

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

// Options
options = [];
selected_option = 0;
has_option = false;
is_showing_options = false;

// example options
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


// global flags
flag_is_delivering = false;

// dialogue bank
function show_dialogue(_id){
	switch _id{
	case 1:
		dialog_threads = [
		[
			["Look at this ", c_red, false],
			["shaking", c_red, true],
			[" word!", c_red, false]
		]]
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
		options[0][0][4] = [MOOD.HAPPY_GREEN, 2, 30]; // effective mood color, mood effect extent, then energy charge
		options[0][0][5] = 201; // result id, any number bigger than 100 and not used
		options[1] = [
			["Sorry, don't think I can lift much right now. ", c_white, false]
		];
		options[1][0][3] = flag_is_delivering;
		options[1][0][4] = [MOOD.DEPRESSED_BLUE, 1, 30];
		options[1][0][5] = 202;
		options[2] = [
			["Sorry, don't have the time right now. ", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.STRESSED_ORANGE, 1, 40];
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
		
		case 5:
		dialog_threads =[[
				["Hey, haven’t seen you in a while. How are you doing?", c_white, false]
			]]
		has_option = true
		options[0] = [
			["I’m good.", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.DEPRESSED_BLUE, 1, 20];
		options[0][0][5] = -1; 
		options[1] = [
			["Yeah, it’s been pretty quiet mostly.", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.DEPRESSED_BLUE, 1, 20];
		options[1][0][5] = -1;
		options[2] = [
			["You know me, just living the dream.", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.DEPRESSED_BLUE, 3, 10];
		options[2][0][5] = -1;
		Break;
	case 6:
		dialog_threads =[[
				["Hey. How's your dad doing these days?", c_white, false]
			]]
		has_option = true
		options[0] = [
			["He's good.", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.DEPRESSED_BLUE, 1, 20];
		options[0][0][5] = -1; 
		options[1] = [
			["I don't know. I haven't seen him in awhile.", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.ANGRY_RED, 3, 30];
		options[1][0][5] = -1;
		options[2] = [
			["He's been better, but he's keeping on.", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.PANIC_PURPLE, 2, 20];
		options[2][0][5] = -1;
		Break;
	case 7:
		dialog_threads =[[
				["It's starting to look pretty cloudy, think it will start snowing?", c_white, false]
			]]
		has_option = true
		options[0] = [
			["Yeah, I love it when it snows.", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.HAPPY_GREEN, 4, 40];
		options[0][0][5] = -1; 
		options[1] = [
			["I hope it doesn't quite yet. I still need to finish painting my house.", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.STRESSED_ORANGE, 1, 10];
		options[1][0][5] = -1;
		options[2] = [
			["You think it will actually snow?", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.HAPPY_GREEN, 1, 20];
		options[2][0][5] = -1;
		Break;
	case 8:
		dialog_threads =[[
				["Did you hear about the doctor deciding to shut down his office?", c_white, false]
			]]
		has_option = true
		options[0] = [
			["Yeah? That's a shame. The town will miss him.", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.DEPRESSED_BLUE, 3, 20];
		options[0][0][5] = -1; 
		options[1] = [
			["That sucks. It's going to be even harder to get a visit now.", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.STRESSED_ORANGE, 2, 20];
		options[1][0][5] = -1;
		options[2] = [
			["I heard he found a bigger office back east. Good for him.", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.PANIC_PURPLE, 1, 20];
		options[2][0][5] = -1;
		Break;
	case 9:
		dialog_threads =[[
				["... what?", c_white, false]
			]]
		has_option = true
		options[0] = [
			["Nothing.", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.DEPRESSED_BLUE, 1, 10];
		options[0][0][5] = -1; 
		options[1] = [
			["...", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.DEPRESSED_BLUE, 1, 10];
		options[1][0][5] = -1;
		options[2] = [
			["I didn't say anything.", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.ANGRY_RED, 1, 20];
		options[2][0][5] = -1;
		Break;
	case 10:
		dialog_threads =[[
				["Hey! I never get to see you anymore. When are you going to come visit again?", c_white, false]
			]]
		has_option = true
		options[0] = [
			["Yeah, I'm sorry. I've been pretty busy lately.", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.STRESSED_ORANGE, 2, 20];
		options[0][0][5] = -1; 
		options[1] = [
			["I'm free tomorrow, want to come over for dinner?", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.PANIC_PURPLE, 3, 30];
		options[1][0][5] = -1;
		options[2] = [
			["Sorry, work's been pretty rough. You're always welcome to swing my my place anytime, however.", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.ANGRY_RED, 4, 30];
		options[2][0][5] = 1002;
		Break;
	case 1002:
    dialog_threads =[[
                ["Oh, I'm probably too busy for awhile.", c_white, false]
            ]]
        break;
		
	case 11:
		dialog_threads =[[
				["I am so tired of this town. Nothing is ever open and everyone is so nosy. Why did I even move here?", c_white, false]
			]]
		has_option = true
		options[0] = [
			["I mean, I like it here...", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.DEPRESSED_BLUE, 2, 20];
		options[0][0][5] = -1; 
		options[1] = [
			["Sorry it sucks so much out here.", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.ANGRY_RED, 3, 30];
		options[1][0][5] = -1;
		options[2] = [
			["Yeah...", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.DEPRESSED_BLUE, 3, 10];
		options[2][0][5] = -1;
		Break;
	case 12:
		dialog_threads =[[
				["I love living here! Don't you?", c_white, false]
			]]
		has_option = true
		options[0] = [
			["Yeah it's nice and quiet here.", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.HAPPY_GREEN, 3, 40];
		options[0][0][5] = -1; 
		options[1] = [
			["Mhm, I really do.", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.HAPPY_GREEN, 2, 30];
		options[1][0][5] = -1;
		options[2] = [
			["Yeah. It's shanged a lot over the years, but it's still home I think. ", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.PANIC_PURPLE, 2, 20];
		options[2][0][5] = -1;
		Break;
	case 13:
		dialog_threads =[[
				["Is everything ok? You look kind of down.", c_white, false]
			]]
		has_option = true
		options[0] = [
			["I'm ok. ", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.DEPRESSED_BLUE, 2, 10];
		options[0][0][5] = -1; 
		options[1] = [
			["Just trying to find my dog. I'll be alright once I find him.", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.DEPRESSED_BLUE, 1, 20];
		options[1][0][5] = -1;
		options[2] = [
			["No. I'm not...", c_white, false], // TODO can you make this option appear on screen, but not able to be selected?
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.DEPRESSED_BLUE, 1, 0];
		options[2][0][5] = -1;
		Break;
	case 14:
		dialog_threads =[[
				["That apartment building is huge! I heard they're planning on replacing the lot next to it with another one.", c_white, false]
			]]
		has_option = true
		options[0] = [
			["That's a huge shame.", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.DEPRESSED_BLUE, 2, 20];
		options[0][0][5] = -1; 
		options[1] = [
			["Seriously? Won't that make everything more crowded?", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.ANGRY_RED, 4, 40];
		options[1][0][5] = -1;
		options[2] = [
			["I miss how this town used to be...", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.DEPRESSED_BLUE, 3, 20];
		options[2][0][5] = -1;
		Break;
	case 15:
		dialog_threads =[[
				["Hello, I found my old football while cleaning out my garage. Would you like to take it?", c_white, false]
			]]
		has_option = true
		options[0] = [
			["Sure, thanks!", c_white, false]
		];
		options[0][0][3] = true
		options[0][0][4] = [MOOD.HAPPY_GREEN, 3, 30];
		options[0][0][5] = -1; 
		options[1] = [
			["I'd love to, but I don't think I have much room for it. ", c_white, false]
		];
		options[1][0][3] = true;
		options[1][0][4] = [MOOD.HAPPY_GREEN, 1, 20];
		options[1][0][5] = -1;
		options[2] = [
			["It might be best to give ti to someone else. I don't think I'd be able to use it much. ", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.DEPRESSED_BLUE, 2, 20];
		options[2][0][5] = -1;
		Break;

		
	case 0:
			dialog_threads =[[
				["Now this is a looooooooooooooooooooooooooong example to show you the auto line switch. ", c_white, false],
			]]
		break;
	case 4:
		break;
	case -1:
		break;
	default:
		is_showing_dialogue = false;
	}
}