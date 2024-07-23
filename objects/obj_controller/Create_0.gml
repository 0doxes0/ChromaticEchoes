/// @description Insert description here
// You can write your code in this editor

global.conversedFather = false;
global.conversed0 = false;
global.conversed1 = false;
global.conversed2 = false;
global.conversed3 = false;
global.conversed4 = false;
global.conversed5 = false;



function start_end_sequence() {
    instance_create_layer(0, 0, "Instances", obj_end_sequence);
    
    // 禁用所有其他对象的绘制
    with (all) {
        if (id != obj_end_sequence.id) {
            visible = false;
        }
    }
}

can_proceed = true;

// Camera set up
enum RES {
    WIDTH = 683,
    HEIGHT = 384,
    SCALE = 2
}

// 设置窗口大小
window_set_size(RES.WIDTH * RES.SCALE, RES.HEIGHT * RES.SCALE);
surface_resize(application_surface, RES.WIDTH, RES.HEIGHT);

// 创建摄像机
var _camera = camera_create_view(0, 0, RES.WIDTH, RES.HEIGHT, 0, obj_player, -1, -1, RES.WIDTH/2, RES.HEIGHT/2);

// 设置视图
view_enabled = true;
view_visible[0] = true;
view_set_camera(0, _camera);

// 设置视口
view_set_wport(0, RES.WIDTH);
view_set_hport(0, RES.HEIGHT);

// GUI 大小设置
display_set_gui_size(RES.WIDTH, RES.HEIGHT);

//face mood indicator
sadfaces = [Sprite19 ,spr_face_happy, spr_face_angry, spr_face_stressed, spr_face_sad, spr_face_anxiety]
faceSize = 3
moodTooltips = ["Vacant", "Happy", "Angry", "Stressed", "Sad", "Anxious"]
TooltipFont = 1;

// player energy
player_max_health = 100;
player_current_health = 100;
health_bar_width = display_get_gui_width() - 60;
health_bar_height = 20;
health_bar_x = 24;
health_bar_y = 10;
flash_timer = 0;
flash_speed = 5; // frequency

randomize(); //random seed regen

// basic dialog
is_showing_dialogue = false;
text_scale = 1;
dialogue_text = ".";
dialogue_id = 0;
dialogue_session = 0;

//long_dialogue essentials
has_nametag = false
nametag = ""
has_next = false // if the dialogue would continue
next = -1

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


gameended = false

// global flags
flag_is_delivering = false;

// dialogue bank
function show_dialogue(_id){
	switch _id{
	case 0:
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
		break;
	case 1:
		dialog_threads =[[
				["Hi. The delivery people left my books out here on the sidewalk. Can you help me bring them in? ", c_white, false]
			]]
		has_option = true
		options[0] = [
			["Of course.", c_white, false]
		];
		options[0][0][3] = !flag_is_delivering; // condition
		options[0][0][4] = [MOOD.HAPPY_GREEN, 2, 30]; // effective mood color, mood effect extent, then energy charge
		options[0][0][5] = 101; // result id, any number bigger than 100 and not used
		options[1] = [
			["Sorry, don't think I can lift much right now. ", c_white, false]
		];
		options[1][0][3] = flag_is_delivering;
		options[1][0][4] = [MOOD.DEPRESSED_BLUE, 1, 30];
		options[1][0][5] = 102;
		options[2] = [
			["Sorry, don't have the time right now. ", c_white, false],
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.STRESSED_ORANGE, 1, 40];
		options[2][0][5] = 103;
		break;
	case 101:
	flag_is_delivering = true; // effect other than mood
	dialog_threads =[[
				["Thank you!", c_white, false]
			]]
		break;
	case 102:
	dialog_threads =[[
				["Oh, I'm sorry to hear that.", c_white, false]
			]]
		break;
	case 103:
	dialog_threads =[[
				["Oh, I understand. ", c_white, false]
			]]
		break;
	case 2:
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
		break;
		
	case 3:
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
		break;
	case 4:
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
		break;
	case 5:
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
		break;
	case 6:
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
		break;
	case 7:
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
		options[2][0][5] = 702;
		break;
	case 702:
    dialog_threads =[[
                ["Oh, I'm probably too busy for awhile.", c_white, false]
            ]]
        break;
		
	case 8:
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
		break;
	case 9:
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
		break;
	case 10:
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
			["No. I'm not...", c_gray, false], // TODO can you make this option appear on screen, but not able to be selected? //NCD, I changed the color though
		];
		options[2][0][3] = true
		options[2][0][4] = [MOOD.DEPRESSED_BLUE, 1, 0];
		options[2][0][5] = -1;
		break;
	case 11:
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
		break;
	case -2:
			dialog_threads =[[
				["Now this is a looooooooooooooooooooooooooong example to show you the auto line switch. ", c_white, false],
			]]
		break;
	case -3:
			effect_mood(MOOD.HAPPY_GREEN, 10)
			nametag = "Dog"
			has_nametag = true
			dialog_threads =[[
				["*Bark! Bark!* ", c_white, true],
				["(Are you looking for me?)", c_white, false]
			]]
			has_next = true;
			next = -4;
		break;
	case -4:
			start_end_sequence();
			effect_mood(MOOD.ANGRY_RED, 10)
			is_showing_dialogue = false;
		break;
	case -100:
			dialog_threads =[[
				["You're exhaulsted. ", c_white, false],
			],
			[
				["You've decided to wait for your dog at home, and ended your little adventure.", c_white, false]
			]]
			has_option = true
			options[0] = [
				["I just want to sleep.", c_white, false]
			];
			options[0][0][3] = true
			options[0][0][4] = [MOOD.DEPRESSED_BLUE, 5, -100];
			options[0][0][5] = -101; 
		break;
	case -101:
		game_end();
		break;
	// Special: Father
	case -200:
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["Hey son. ", c_white, false],
			]]
			has_next = true;
			next = -201;
		break;
	case -201:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["Hi, dad. ", c_white, false],
			]]
			has_next = true;
			next = -202;
		break;
	case -202:
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["Still can't cheer up, huh? ", c_white, false],
			]]
			has_next = true;
			next = -203;
		break;
	case -203:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["Dad..", c_white, false],
			]]
			has_next = true;
			next = -204;
		break;
	case -204:
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["- It's been a year now. ", c_white, false],
			]]
			has_next = true;
			next = -205;
		break;
	case -205:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["She's gone, dad! How can I just cheer up after she died?!", c_white, false],
			]]
			has_next = true;
			next = -206;
		break;
	case -206:
			effect_mood(MOOD.ANGRY_RED,1);
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["Yeah I get it, but life can't just keep ", c_white, false],
				["waiting ", c_red, false],
				["for you! You need to get back up on that horse, you know?", c_white, false]
			]]
			has_next = true;
			next = -207;
		break;
	case -207:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["...", c_white, false],
			]]
			has_next = true;
			next = -208;
		break;
	case -208:
			effect_mood(MOOD.ANGRY_RED,1);
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["Everyone loses people, son. How long are you going to let yourself be trapped like this? ", c_white, false],
				["Reality isn't going to change anytime soon.", c_red, false]
			]]
			has_next = true;
			next = -209;
		break;
	case -209:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["How can you even say that?! She meant more to me than I do to myself. I can't just move on and leave her behind like that!", c_white, false],
			]]
			has_next = true;
			next = -210;
		break;
	case -210:
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["Talking like that is useless! How is bumming around town going to help you move on at all? Walking around feeling sorry for yourself isn't helping!", c_white, false],
			]]
			has_next = true;
			next = -211;
		break;
	case -211:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["Seriously dad? Mom's still around, would you be talking like that if she died too? ", c_white, false],
			]]
			has_next = true;
			next = -212;
		break;
	case -212:
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["Hey! I'm just trying to help you pull your head out of the", c_white, false],
				[" past ", c_purple, false],
				["so you can go back to being you!", c_white, false]
			]]
			has_next = true;
			next = -213;
		break;
	case -213:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["Did I go somewhere? I'm still me, I never stopped. ", c_white, false],
			]]
			has_next = true;
			next = -214;
		break;
	case -214:
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["The old you wouldn't waste away ", c_white, false],
				["feeling sorry for yourself. ", c_red, false]
			]]
			has_next = true;
			next = -215;
		break;
	case -215:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["The old me? ", c_white, false],
			]]
			has_next = true;
			next = -216;
		break;
	case -216:
			effect_mood(MOOD.ANGRY_RED,2);
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["I'm trying to help you out, son. Locking yourself up in a ", c_white, false],
				["cage", c_white, true],
				[" like this isn't helping you move on." , c_white, false]				
			]]
			has_next = true;
			next = -217;
		break;
	case -217:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["I don't need your help, dad! You aren't helping anyone!", c_white, false],
			]]
			has_next = true;
			next = -218;
		break;
	case -218:
			nametag = "Father"
			has_nametag = true
			dialog_threads =[[
				["I've lost people too. I know it hurts, but you're acting like your loss is special! Everyone out there has the same", c_white, false],
				[" pain ", c_blue, false],
				["as you!", c_white, false]
			]]
			has_next = true;
			next = -219;
		break;
	case -219:
			nametag = "Player"
			has_nametag = true
			dialog_threads =[[
				["I can't do this anymore. What kind of father talks like this? ", c_white, false],
			]]
			has_next = false;
		break;
	//end of Father dialogue	
	
	case -1:
	default:
		is_showing_dialogue = false;
	}
}