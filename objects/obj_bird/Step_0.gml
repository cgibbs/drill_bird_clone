ticks += 1;

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

if (keyboard_check(vk_left) and !place_meeting(x+hspeed - 1, y, collision_objects)) {
	hspeed -= MOVE_ACCEL;
	if (hspeed * -1 > MAX_MOVE_SPEED) hspeed = MAX_MOVE_SPEED * -1;
} else if (keyboard_check(vk_right) and !place_meeting(x+ hspeed + 1, y, collision_objects)) {
	hspeed += MOVE_ACCEL;
	if (hspeed > MAX_MOVE_SPEED) hspeed = MAX_MOVE_SPEED;
} else {
	hspeed = 0;	
}

if (keyboard_check(vk_left) 
	and place_meeting(x - 4, y, breakable_objects)
	and ticks % 10 == 0) 
	{
	show_debug_message("drilling!");
	var inst = collision_circle(x-5, y, 2, breakable_objects, false, true);
	inst.hp -= BREAK_DMG;
	if (inst.drilled == false) {
		inst.drilled = true;
		// two seconds, might move this to an object variable to make it less of a magic number,
		// and also calculate it based on drill speed for the bird?
		inst.alarm[0] = game_get_speed(gamespeed_fps) * 2;
	}
	if (inst.hp < 1) instance_destroy(inst);
}

if (keyboard_check(vk_right) 
	and place_meeting(x + 4, y, breakable_objects)
	and ticks % 10 == 0) 
	{
	show_debug_message("drilling!");
	var inst = collision_circle(x+TILE_SIZE+5, y, 2, breakable_objects, false, true);
	inst.hp -= BREAK_DMG;
	if (inst.drilled == false) {
		inst.drilled = true;
		// two seconds, might move this to an object variable to make it less of a magic number,
		// and also calculate it based on drill speed for the bird?
		inst.alarm[0] = game_get_speed(gamespeed_fps) * 2;
	}
	if (inst.hp < 1) instance_destroy(inst);
}

if (keyboard_check(vk_down) 
	and place_meeting(x+(TILE_SIZE/2), y + TILE_SIZE + 4, breakable_objects)
	and ticks % 10 == 0) 
	{
	show_debug_message("drilling!");
	var inst = collision_circle(x+(TILE_SIZE/2), y + TILE_SIZE + 4, 2, breakable_objects, false, true);
	inst.hp -= BREAK_DMG;
	if (inst.drilled == false) {
		inst.drilled = true;
		// two seconds, might move this to an object variable to make it less of a magic number,
		// and also calculate it based on drill speed for the bird?
		inst.alarm[0] = game_get_speed(gamespeed_fps) * 2;
	}
	if (inst.hp < 1) instance_destroy(inst);
}