// reset health if block not destroyed within two seconds (set by player object)
// probably a better way to do this, but the main goal for now is to keep all the blocks
// from running step-based checks to know when to "heal"
hp = MAX_HP;
drilled = false;
show_debug_message("reset HP for sand block");