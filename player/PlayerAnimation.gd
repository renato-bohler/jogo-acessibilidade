extends Node

var last_direction

func handle_animation(player, animation_sprite):
	
	if player.movement_direction == PlayerActions.ActionDirection.MOVE_UP:
		last_direction = PlayerActions.ActionDirection.MOVE_UP
		animation_sprite.play("running_up")
		animation_sprite.set_rotation(0)
		return
		
	if player.movement_direction == PlayerActions.ActionDirection.MOVE_DOWN:
		last_direction = PlayerActions.ActionDirection.MOVE_DOWN
		animation_sprite.play("running_down")
		animation_sprite.set_rotation(180)
		return
	
	if player.movement_direction == PlayerActions.ActionDirection.MOVE_LEFT:
		last_direction = PlayerActions.ActionDirection.MOVE_LEFT
		animation_sprite.play("running_left")
		animation_sprite.set_rotation(90)
		return
	
	if player.movement_direction == PlayerActions.ActionDirection.MOVE_RIGHT:
		last_direction = PlayerActions.ActionDirection.MOVE_RIGHT
		animation_sprite.play("running_right")
		animation_sprite.set_rotation(270)
		return
		
	if last_direction == PlayerActions.ActionDirection.MOVE_UP:
		animation_sprite.play("idle_back")
		return
		
	if last_direction == PlayerActions.ActionDirection.MOVE_DOWN:
		animation_sprite.play("idle_front")
		return
		
	if last_direction == PlayerActions.ActionDirection.MOVE_LEFT:
		animation_sprite.play("idle_left")
		return
		
	if last_direction == PlayerActions.ActionDirection.MOVE_RIGHT:
		animation_sprite.play("idle_right")
		return