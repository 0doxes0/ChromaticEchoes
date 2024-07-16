/// @description Insert description here
// You can write your code in this editor

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