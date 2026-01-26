ticks += 1;

if (!place_meeting(x, y+1, collision_objects)) {
	vspeed += DROP_SPEED;
	if (vspeed > MAX_DROP_SPEED) vspeed = MAX_DROP_SPEED;
	if (keyboard_check_pressed(vk_space)) {
		if (vspeed > 0) vspeed = 0;
		vspeed += HOP_SPEED;
		if (vspeed < MAX_HOP_SPEED) vspeed = MAX_HOP_SPEED;
	}
} else if (keyboard_check_pressed(vk_space) and !place_meeting(x, y-1, collision_objects)) {
	vspeed +=HOP_SPEED;
	if (vspeed < MAX_HOP_SPEED) vspeed = MAX_HOP_SPEED;
} else {
	if (vspeed > 0 and y % 64 != 0) y = y - (y%64);
	else if (vspeed < 0  and y % 64 != 0) y = y + (y%64);
	vspeed = 0;
}

if (keyboard_check(vk_left)) facing = "left";
else if (keyboard_check(vk_right)) facing = "right";

if (keyboard_check(vk_left) and !place_meeting(x+hspeed - 1, y, collision_objects)) {
	hspeed -= MOVE_ACCEL;
	if (hspeed * -1 > MAX_MOVE_SPEED) hspeed = MAX_MOVE_SPEED * -1;
} else if (keyboard_check(vk_right) and !place_meeting(x+ hspeed + 1, y, collision_objects)) {
	hspeed += MOVE_ACCEL;
	if (hspeed > MAX_MOVE_SPEED) hspeed = MAX_MOVE_SPEED;
} else {
	hspeed = 0;	
}

if (keyboard_check(vk_left) and vspeed == 0 
	and place_meeting(x - 4, y+(TILE_SIZE/2), breakable_objects)
	and ticks % 10 == 0) 
	{
	show_debug_message("drilling!");
	var inst = collision_circle(x-5, y+(TILE_SIZE/2), 2, breakable_objects, false, true);
	if (inst > 1) {
		inst.hp -= BREAK_DMG;
		if (inst.drilled == false) {
			inst.drilled = true;
			// two seconds, might move this to an object variable to make it less of a magic number,
			// and also calculate it based on drill speed for the bird?
			inst.alarm[0] = game_get_speed(gamespeed_fps) * 2;
		}
		if (inst.hp < 1) instance_destroy(inst, true);	
	}
}

if (keyboard_check(vk_right) and vspeed == 0 
	and place_meeting(x + 4, y+(TILE_SIZE/2), breakable_objects)
	and ticks % 10 == 0) 
	{
	show_debug_message("drilling!");
	var inst = collision_circle(x+TILE_SIZE+5, y+(TILE_SIZE/2), 2, breakable_objects, false, true);
	if (inst > 1) {
		inst.hp -= BREAK_DMG;
		if (inst.drilled == false) {
			show_debug_message("starting drill damage!");
			inst.drilled = true;
			// two seconds, might move this to an object variable to make it less of a magic number,
			// and also calculate it based on drill speed for the bird?
			inst.alarm[0] = game_get_speed(gamespeed_fps) * 2;
		}
		if (inst.hp < 1) {
			instance_destroy(inst);
			show_debug_message("destroying drilled thing!");
		}
	}	
}

if (keyboard_check(vk_down) and vspeed == 0 
	and place_meeting(x+(TILE_SIZE/2), y + TILE_SIZE + 4, breakable_objects)
	and ticks % 10 == 0) 
	{
	show_debug_message("drilling!");
	var inst = collision_circle(x+(TILE_SIZE/2), y + TILE_SIZE + 4, 2, breakable_objects, false, true);
	if (inst > 1) {
		inst.hp -= BREAK_DMG;
		if (inst.drilled == false) {
			inst.drilled = true;
			// two seconds, might move this to an object variable to make it less of a magic number,
			// and also calculate it based on drill speed for the bird?
			inst.alarm[0] = game_get_speed(gamespeed_fps) * 2;
		}
		if (inst.hp < 1) instance_destroy(inst);
	}
}

if (keyboard_check(vk_up) and vspeed == 0 
	and place_meeting(x+(TILE_SIZE/2), y - 4, breakable_objects)
	and ticks % 10 == 0) 
	{
	show_debug_message("drilling!");
	var inst = collision_circle(x+(TILE_SIZE/2), y - 4, 2, breakable_objects, false, true);
	if (inst > 1) {
		inst.hp -= BREAK_DMG;
		if (inst.drilled == false) {
			inst.drilled = true;
			// two seconds, might move this to an object variable to make it less of a magic number,
			// and also calculate it based on drill speed for the bird?
			inst.alarm[0] = game_get_speed(gamespeed_fps) * 2;
		}
		if (inst.hp < 1) instance_destroy(inst);
	}
}

if (facing == "left") {
	if (succed_item == undefined) image_index = 0;
	else image_index = 4;
} else if (facing == "right") {
	if (succed_item == undefined) image_index = 1;	
	else image_index = 5;
}

if (keyboard_check(vk_shift) and can_succ) {
	if (succed_item == undefined) {	
		// do the succ
		if (facing == "left") {
			image_index = 2;
			var inst = collision_circle(x-(TILE_SIZE)+10, y+(TILE_SIZE/2), 2, breakable_objects, false, true);
			if (inst) {
				succed_item = inst.object_index;
				// intentionally not triggering the destroy stuff, that's
				// what makes succing distinct from drilling at the moment
				instance_destroy(inst, false);
				can_succ = false;
				alarm[0] = game_get_speed(gamespeed_fps) * .4;
			}
		} else if (facing == "right") {
			image_index = 3;	
			var inst = collision_circle(x+(TILE_SIZE * 2), y+(TILE_SIZE/2), 2, breakable_objects, false, true);
			if (inst) {
				succed_item = inst.object_index;
				// intentionally not triggering the destroy stuff, that's
				// what makes succing distinct from drilling at the moment
				instance_destroy(inst, false);
				can_succ = false;
				alarm[0] = game_get_speed(gamespeed_fps) * .4;
			}
		}
	} else {
	// spit it out
		if (facing == "left" and !place_meeting(x-TILE_SIZE-10, y, collision_objects)) {
			var new_inst_x = (x-TILE_SIZE-10) - ((x-TILE_SIZE-10) % 64);
			var new_inst_y = y;
			instance_create_layer(new_inst_x, new_inst_y, "Instances", succed_item);
			succed_item = undefined;
			can_succ = false;
			alarm[0] = game_get_speed(gamespeed_fps) * .4;
		} else if (facing == "right" and !place_meeting((x + (TILE_SIZE ) - 10), y, collision_objects)) {
			var new_inst_x = (x + (TILE_SIZE * 2) - 10) - ((x+TILE_SIZE-10) % 64);
			var new_inst_y = y - (y%64);
			instance_create_layer(new_inst_x, new_inst_y, "Instances", succed_item);
			succed_item = undefined;
			can_succ = false;
			alarm[0] = game_get_speed(gamespeed_fps) * .4;
		}
	}
}