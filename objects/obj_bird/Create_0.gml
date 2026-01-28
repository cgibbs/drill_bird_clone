TILE_SIZE = 64;
DROP_SPEED = 3;
MAX_DROP_SPEED = 15;
HOP_SPEED = -30;
MAX_HOP_SPEED = -50;
MOVE_ACCEL = 1;
MAX_MOVE_SPEED = 10;
collision_objects = [obj_brick, obj_dirt, obj_sand, obj_thwomp];
breakable_objects = [obj_dirt, obj_sand];
BREAK_DMG = 1;

ticks = 0;

image_speed = 0;

facing = "left";
succed_item = undefined;
can_succ = true;
drilling = false;