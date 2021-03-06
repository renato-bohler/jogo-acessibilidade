extends Node

func handle_movement(player):
	var action = self.get_player_action()
	player = self.handle_action_selected(player, action)
	player.walk()
	return player
	

func handle_action_selected(player, action):
	player.movement_direction = action
	if action == PlayerActions.ActionDirection.MOVE_UP:
		player.desired_movement.y = -1
		player.desired_movement.x = 0
		player.desired_rotation = 0
		return player
		
	if  action == PlayerActions.ActionDirection.MOVE_LEFT:
		player.desired_movement.x = -1
		player.desired_movement.y = 0
		player.desired_rotation = 270
		return player
		
	if  action == PlayerActions.ActionDirection.MOVE_RIGHT:
		player.desired_movement.x = 1
		player.desired_movement.y = 0
		player.desired_rotation = 90
		return player
		
	if  action == PlayerActions.ActionDirection.MOVE_DOWN:
		player.desired_movement.y = 1
		player.desired_movement.x = 0
		player.desired_rotation = 180
		return player
		
	player.desired_movement.x = 0
	player.desired_movement.y = 0
	return player

func get_player_action():
	if self.is_move_up():
		return PlayerActions.ActionDirection.MOVE_UP
		
	if self.is_move_down():
		return PlayerActions.ActionDirection.MOVE_DOWN
		
	if self.is_move_left():
		return PlayerActions.ActionDirection.MOVE_LEFT
		
	if self.is_move_right():
		return PlayerActions.ActionDirection.MOVE_RIGHT
		
	return PlayerActions.ActionDirection.NO_ACTION

func is_move_up():
	return Input.is_action_pressed("ui_up")

func is_move_down():
	return Input.is_action_pressed("ui_down")
	
func is_move_left():
	return Input.is_action_pressed("ui_left")
	
func is_move_right():
	return Input.is_action_pressed("ui_right")
	