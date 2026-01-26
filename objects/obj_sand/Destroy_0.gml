// check for surrounding blocks of the same type and set their destroy timers
for(var xx,yy,inst,i=0; i<9; i++) {
	if i==4 continue;
	xx=(i mod 3-1)*TILE_SIZE;
	yy=(i div 3-1)*TILE_SIZE;
	inst=instance_position(x+xx,y+yy,obj_sand);
	//whatever you want from there
	if (inst > 1) {
		inst.alarm[1] = game_get_speed(gamespeed_fps) * .1;
	}
}