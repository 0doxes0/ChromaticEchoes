/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_black);
draw_set_alpha(fade_alpha);
draw_rectangle(0, 0, RES.WIDTH, RES.HEIGHT, false);
draw_set_alpha(1);

if (state == "scroll_credits" || state == "end") {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    for (var i = 0; i < array_length(credits_text); i++) {
        draw_text(RES.WIDTH/2, credits_y + i * 30, credits_text[i]);
    }
}