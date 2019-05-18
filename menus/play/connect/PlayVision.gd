extends Control

func _play_sound(filename, type = "wav"):
	var vstream = load("res://assets/sounds/menus/{filename}.{type}".format({"filename": filename, "type": type}))
	$Speaker.set_stream(vstream)
	$Speaker.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect every press event to change scene accordingly
	for button in $WaitingConnection/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Animate the loading icon
	$WaitingConnection/Menu/LoadingContainer/Loading/AnimationPlayer.play("Rotate")

	# Focus the back button
	var focus = $WaitingConnection/Menu/Buttons/BackButton
	focus.grab_focus()
	
	_play_sound("waitingforplayer")
	yield($Speaker, "finished")
	_play_sound("abort")
	yield($Speaker, "finished")
	_play_sound("tic_toc", "ogg")
	_open_server()

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)
	
func _open_server():
	print('TODO: open server')