extends Control

onready var speaker = get_node("/root/Speaker")
onready var sound_navigation = get_node("/root/SoundNavigation")

func _play_sound(filename, type = "wav"):
	if (sound_navigation.pressed):
		var vstream = load("res://assets/sounds/menus/{filename}.{type}".format({"filename": filename, "type": type}))
		speaker.set_stream(vstream)
		speaker.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect every press event to change sce4ne accordingly
	for button in $WaitingConnection/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Animate the loading icon
	$WaitingConnection/Menu/LoadingContainer/Loading/AnimationPlayer.play("Rotate")
	
	# Focus the back button
	var focus = $WaitingConnection/Menu/Buttons/BackButton
	focus.grab_focus()
	
	_play_sound("waitingforplayer")
	yield(speaker, "finished")
	_play_sound("abort")
	yield(speaker, "finished")
	_play_sound("tic_toc", "ogg")
	_open_server()

func _on_Button_pressed(scene_to_load):
	if (scene_to_load):
		get_tree().change_scene(scene_to_load)
	
func _open_server():
	print('TODO: open server')