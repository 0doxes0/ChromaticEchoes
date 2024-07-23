/// @description Insert description here
// You can write your code in this editor
switch(state) {
    case "fade_in":
        fade_alpha += 0.01;
        if (fade_alpha >= 1) {
            state = "show_credits";
            alarm[0] = 60; // 等待1秒后显示制作人员名单
        } else {
            alarm[0] = 1;
        }
        break;
    
    case "show_credits":
        credits_y = RES.HEIGHT;
        state = "scroll_credits";
        alarm[0] = 1;
        break;
    
    case "scroll_credits":
        credits_y -= 0.5;
        if (credits_y < -array_length(credits_text) * 22.5) {
            state = "end";
            alarm[0] = 120; // 等待2秒后结束
        } else {
            alarm[0] = 1;
        }
        break;
    
    case "end":
        game_end();
        break;
}