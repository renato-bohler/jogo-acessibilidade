extends Control

const PORT = 7788

onready var speaker = get_node("/root/Speaker")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect every press event to change sce4ne accordingly
	for button in $WaitingConnection/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Animate the loading icon
	$WaitingConnection/Menu/LoadingContainer/Loading/AnimationPlayer.play("Rotate")
	
	# Networking signal connections should go here
	# ============================================
	Networking.connect("connected", self, "_peer_connected")
	# ============================================
	
	# Focus the back button
	var focus = $WaitingConnection/Menu/Buttons/BackButton
	focus.grab_focus()
	
	speaker.play_sound("waitingforplayer")
	yield(speaker, "finished")
	speaker.play_sound("abort")
	yield(speaker, "finished")
	speaker.play_sound("tic_toc", "ogg")
	_open_server()

func _on_Button_pressed(scene_to_load):
	if (scene_to_load):
		get_tree().change_scene(scene_to_load)
	
func _open_server():
	Networking.host_game(PORT)

func _peer_connected(id):
	print("Received a peer connection, their id is: " + id)