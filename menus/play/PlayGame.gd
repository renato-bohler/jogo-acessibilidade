extends Control

func _play_sound(filename):
	var vstream = load("res://assets/sounds/menus/%s.wav" % filename)
	$Speaker.set_stream(vstream)
	$Speaker.play()

func _ready():
	# Connect every press event to change scene accordingly
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Focus the first button on the menu
	var focus = $Menu/CenterRow/Buttons/VisionModeButton
	focus.grab_focus()
	
	# Play the title sound and wait
	_play_sound("playgame_title")
	yield($Speaker, "finished")
	if get_focus_owner() == focus:
		_play_sound("playvision")

func _on_Button_pressed(scene_to_load):
	if (scene_to_load):
		get_tree().change_scene(scene_to_load)

func _on_VisionModeButton_focus_entered():
	_play_sound("playvision")


func _on_HearingModeButton_focus_entered():
	_play_sound("playhearing")


func _on_BackButton_focus_entered():
	_play_sound("back")
