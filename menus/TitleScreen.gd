extends Control

onready var speaker = get_node("/root/Speaker")
onready var sound_navigation = get_node("/root/SoundNavigation")

func _play_sound(filename):
	if (sound_navigation.pressed):
		var vstream = load("res://assets/sounds/menus/%s.wav" % filename)
		speaker.set_stream(vstream)
		speaker.play()

func _ready():
	# Connect every press event to change scene accordingly
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Focus the first button on the menu
	var focus = $Menu/CenterRow/Buttons/PlayButton
	focus.grab_focus()
	
	# Play the title sound and wait
	_play_sound("titlescreen_title")
	yield(speaker, "finished")
	if get_focus_owner() == focus:
		_play_sound("playgame")

func _on_Button_pressed(scene_to_load):
	if (scene_to_load):
		get_tree().change_scene(scene_to_load)

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_PlayButton_focus_entered():
	_play_sound("playgame")

func _on_TutorialButton_focus_entered():
	_play_sound("tutorial")

func _on_ExitButton_focus_entered():
	_play_sound("exit")
