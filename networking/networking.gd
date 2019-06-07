extends Node

# Signals 
# For pre-game
signal connection_fail()
signal peer_disconnected()
signal game_finished()
signal ready_start()
signal start_game()
signal connected(id)
signal sync_scene(scene)

# In game communication
signal direction_warning(direction)
signal new_position(position, rotation)

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

var peer_id = -1

# Join a host (for audio client use)
func join_game(ip : String, port : int):
	var server = NetworkedMultiplayerENet.new()
	server.create_client(ip, port)
	get_tree().set_network_peer(server)

# Host a game (for visual client use)
func host_game(port : int):
	var server = NetworkedMultiplayerENet.new()
	server.create_server(port, 2) # Max 2 players
	get_tree().set_network_peer(server)

func _ready():
	# Connecting networking signals
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_peer_disconnected")
	
# Since it's only one server and one client, no need to warn other peers that connection happened,
# so just pass the signal up for the interface to handle
func _player_connected(id):
	emit_signal("connected", id)
	peer_id = id
	

func _connected_ok():
	emit_signal("connected", 1)
	peer_id = 1

func _connected_fail():
	get_tree().set_network_peer(null)
	emit_signal("connection_fail")

func _peer_disconnected():
	get_tree().set_network_peer(null)
	emit_signal("peer_disconnected")
	peer_id = -1

# The server calls this function to update the player position on the audio client 
remote func _update_position(pos : Vector2, rotation: int):
	emit_signal("new_position", pos, rotation)

func update_position(pos : Vector2, rotation: int):
	rpc_id(peer_id, "_update_position", pos, rotation)

#----------------------------------------------------------

# The audio client calls this on the server to send a warning
# Use DIR(ection) enum
remote func _send_warning(direction):
	emit_signal("direction_warning", direction)

func send_warning(direction):
	rpc_id(peer_id, "_send_warning", direction)

#----------------------------------------------------------

# Client tells server that it's ready for the match
# Will will wait for "start_match" from the server
remote func _ready_to_start():
	emit_signal("ready_start")

func ready_to_start():
	rpc_id(peer_id, "_ready_to_start")
	

#----------------------------------------------------------

# Server tells client to start the match
# Should wait for "ready_to_start" if hasn't received it yet
remote func _start_game():
	emit_signal("start_game")

func start_game():
	rpc_id(peer_id, "_start_game")

#----------------------------------------------------------

# Server tells the client to change scenes
remote func _sync_scene(scene):
	emit_signal("change_scene", scene)
	
func sync_scene(scene : String):
	rpc_id(peer_id, "_sync_scene", scene)

#----------------------------------------------------------

# Server tells client to end the game because it won
remote func _game_win():
	emit_signal("game_finished")
	get_tree().set_network_peer(null)
	peer_id = -1

func game_win():
	rpc_id(peer_id, "_game_win")

#----------------------------------------------------------

# Call when you want to quit the game
# Tells the other peer you disconnected automagically
func quit_game():
	get_tree().set_network_peer(null)
	peer_id = -1
