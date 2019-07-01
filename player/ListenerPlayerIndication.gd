extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("listener_player_indication")

func show_indication(listener_action):
	self.reset_all_indications()
			
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_UP:
		$indicate_up.show()
		return 
		
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_DOWN:
		$indicate_down.show()
		return 
		
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_LEFT:
		$indicate_left.show()
		return 
		
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_RIGHT:
		$indicate_right.show()
		return 
	
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_UPPER_LEFT:
		$indicate_upper_left.show()
		return 
	
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_UPPER_RIGHT:
		$indicate_upper_right.show()
		return 
		
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_LOWER_LEFT:
		$indicate_lower_left.show()
		return 
	
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_LOWER_RIGHT:
		$indicate_lower_right.show()
		return 
	
func get_indication():
	
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_UPPER_LEFT
		
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_UPPER_RIGHT
	
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_LOWER_LEFT
	
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_LOWER_RIGHT
		
	if Input.is_action_pressed("ui_up"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_UP
		
	if Input.is_action_pressed("ui_down"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_DOWN
		
	if Input.is_action_pressed("ui_left"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_LEFT
		
	if Input.is_action_pressed("ui_right"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_RIGHT
		
	return ListenerPlayerActions.ListenerPlayerActions.NO_INDICATION
	
func reset_all_indications():
	$indicate_up.hide()
	$indicate_down.hide()
	$indicate_left.hide()
	$indicate_right.hide()
	$indicate_upper_left.hide()
	$indicate_upper_right.hide()
	$indicate_lower_left.hide()
	$indicate_lower_right.hide()