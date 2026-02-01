if (!place_meeting(x, y+1, collision_objects) and still and !timer_set) {
	show_debug_message("set fall timer!");
	alarm[0] = game_get_speed(gamespeed_fps) * 1;
	timer_set = true;
} else if (!still) {
	vspeed = 20;
}
if (place_meeting(x, y+1, collision_objects) and !still) {
	show_debug_message("else!");
	if (vspeed > 0 and y % 64 != 0) y = y - (y%64);
	else if (vspeed < 0  and y % 64 != 0) y = y + (y%64);
	vspeed = 0;
	audio_play_sound(sndThwompLand, 8, false);
	still = true;
	timer_set = false;
}