/// @description Insert description here
// You can write your code in this editor

remaininglife -= 1;
image_alpha = remaininglife / lifespan;
if (remaininglife <= 0) {
    instance_destroy();
}
