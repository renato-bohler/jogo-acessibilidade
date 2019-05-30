extends Node

onready var indicate_up = get_node("indicate_up")
onready var indicate_down = get_node("indicate_down")
onready var indicate_left = get_node("indicate_left")
onready var indicate_right = get_node("indicate_right")
onready var indicate_upper_left = get_node("indicate_upper_left")
onready var indicate_upper_right = get_node("indicate_upper_right")
onready var indicate_lower_left = get_node("indicate_lower_left")
onready var indicate_lower_right = get_node("indicate_lower_right")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("listener_player_indication")

func handle_indication():
	var listener_action = self.get_indication()
	self.reset_all_indications()
			
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_UP:
		indicate_up.show()
		return 
		
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_DOWN:
		indicate_down.show()
		return 
		
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_LEFT:
		indicate_left.show()
		return 
		
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_RIGHT:
		indicate_right.show()
		return 
	
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_UPPER_LEFT:
		indicate_upper_left.show()
		return 
	
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_UPPER_RIGHT:
		indicate_upper_right.show()
		return 
		
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_LOWER_LEFT:
		indicate_lower_left.show()
		return 
	
	if listener_action == ListenerPlayerActions.ListenerPlayerActions.INDICATE_LOWER_RIGHT:
		indicate_lower_right.show()
		return 
	
func get_indication():
	if Input.is_action_pressed("ui_listener_up") and Input.is_action_pressed("ui_listener_left"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_UPPER_LEFT
		
	if Input.is_action_pressed("ui_listener_up") and Input.is_action_pressed("ui_listener_right"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_UPPER_RIGHT
	
	if Input.is_action_pressed("ui_listener_down") and Input.is_action_pressed("ui_listener_left"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_LOWER_LEFT
	
	if Input.is_action_pressed("ui_listener_down") and Input.is_action_pressed("ui_listener_right"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_LOWER_RIGHT
		
	if Input.is_action_pressed("ui_listener_up"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_UP
		
	if Input.is_action_pressed("ui_listener_down"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_DOWN
		
	if Input.is_action_pressed("ui_listener_left"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_LEFT
		
	if Input.is_action_pressed("ui_listener_right"):
		return ListenerPlayerActions.ListenerPlayerActions.INDICATE_RIGHT
		
	return ListenerPlayerActions.ListenerPlayerActions.NO_INDICATION
	
func reset_all_indications():
	indicate_up.hide()
	indicate_down.hide()
	indicate_left.hide()
	indicate_right.hide()
	indicate_upper_left.hide()
	indicate_upper_right.hide()
	indicate_lower_left.hide()
	indicate_lower_right.hide()