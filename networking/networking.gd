extends Node

# Signals 
# For pre-game
signal connection_fail()
signal peer_disconnected()
signal game_finished()
signal ready_start()
signal start_game()

# In game communication
signal direction_warning(direction)
signal new_postion(position)

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

# Join a host (for audio client use)
func join_game(ip : String, port : int):
	var server = NetworkedMultiplayerENet.new()
	server.create_client(ip, port)
	get_tree().set_networked_peer(server)

# Host a game (for visual client use)
func host_game(port : int):
	var server = NetworkedMultiplayerENet.new()
	server.create_server(port, 2) # Max 2 players
	get_tree().set_networked_peer(server)

func _ready():
	# Connecting networking signals
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_peer_disconnected")
	

func _player_connected(id):
	pass

func _connected_ok():
	pass

func _connected_fail():
	get_tree().set_network_peer(null)
	emit_signal("connection_fail")

func _peer_disconnected():
	get_tree().set_network_peer(null)
	emit_signal("peer_disconnected")

# The server calls this function to update the player position on the audio client 
remote func update_postion(pos : Vector2):
	emit_signal("new_postion", pos)
	
# The audio client calls this on the server to send a warning
# Use DIR(ection) enum
remote func send_warning(direction):
	emit_signal("direction_warning", direction)
	
# Client tells server that it's ready for the match
# Will will wait for "start_match" from the server
remote func ready_to_start():
	emit_signal("ready_start")

# Server tells client to start the match
# Should wait for "ready_to_start" if hasn't received it yet
remote func start_game():
	emit_signal("start_game")
	
# Server tells client to end the game because it won
remote func game_win():
	emit_signal("game_finished")
	get_tree().set_network_peer(null)
	
# Call when you want to quit the game
# Tells the other peer you disconnected automagically
func quit_game():
	get_tree().set_network_peer(null)
	


