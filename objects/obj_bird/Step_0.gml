var DROP_SPEED = 5;
var MAX_DROP_SPEED = 20;
var HOP_SPEED = -30;
var MAX_HOP_SPEED = -50;
var MOVE_ACCEL = 1;
var MAX_MOVE_SPEED = 10;

if (!place_meeting(x, y+1, collision_objects)) {
	vspeed += DROP_SPEED;
	if (vspeed > MAX_DROP_SPEED) vspeed = MAX_DROP_SPEED;
	if (keyboard_check_pressed(vk_space)) {
		if (vspeed > 0) vspeed = 0;
		vspeed += HOP_SPEED;
		if (vspeed < MAX_HOP_SPEED) vspeed = MAX_HOP_SPEED;
	}
} else if (keyboard_check_pressed(vk_space)) {
	vspeed +=HOP_SPEED;
	if (vspeed < MAX_HOP_SPEED) vspeed = MAX_HOP_SPEED;
} else {	
	vspeed = 0;
	y = y - (y%64);
}

if (keyboard_check(vk_left) and !place_meeting(x-MAX_MOVE_SPEED, y, collision_objects)) {
	hspeed -= MOVE_ACCEL;
	if (hspeed * -1 > MAX_MOVE_SPEED) hspeed = MAX_MOVE_SPEED * -1;
} else if (keyboard_check(vk_right) and !place_meeting(x+MAX_MOVE_SPEED, y, collision_objects)) {
	hspeed += MOVE_ACCEL;
	if (hspeed > MAX_MOVE_SPEED) hspeed = MAX_MOVE_SPEED;
} else {
	hspeed = 0;	
}

