extends Node

# Signals for the main game
signal connection_fail()
signal peer_disconnected()

# Enum for directions for warnings
# Should probably move it out of here
enum DIR {
	UP,
	UP_LEFT,
	UP_RIGHT,
	LEFT,
	RIGHT,
	DOWN,
	DOWN_LEFT,
	DOWN_RIGHT
}

# Join a host (visual client)
func join_game(ip : String, port : int):
	pass

func _ready():
	# Connecting networking signals
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	

func _player_connected(id):
	pass

func _player_disconnected(id):
	pass

func _connected_ok():
	pass

func _connected_fail():
	pass

func _server_disconnected():
	pass

# The server calls this function to update the player position on the audio client 
remote func update_postion(pos_x, pos_y):
	pass
	
# The audio client calls this on the server to send a warning
# Use DIR(ection) enum
remote func send_warning(direction):
	pass
	
# Client tells server that it's ready for the match
# Will will wait for "start_match" from the server
remote func ready_to_start():
	pass

# Server tells client to start the match
# Should wait for "ready_to_start" if hasn't received it yet
remote func start_game():
	pass
	
# Call when you want to quite the game
func quit_game():
	pass


