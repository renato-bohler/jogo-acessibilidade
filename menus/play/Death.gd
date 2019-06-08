extends Control

onready var speaker = get_node("/root/Speaker")

func _ready():
	# Connect every press event to change scene accordingly
	for button in $VBoxContainer/Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Focus the first button on the menu
	var focus = $VBoxContainer/Menu/CenterRow/Buttons/RetryButton
	focus.grab_focus()
	
	# Play the title sound and wait
	speaker.play_sound("death", true)
	yield(speaker, "finished")
	#speaker.play_sound("death_title")
	#yield(speaker, "finished")
	if get_focus_owner() == focus:
		speaker.play_sound("retry")

func _on_Button_pressed(scene_to_load):
	if (scene_to_load):
		speaker.stop_sound()
		SceneChanger.change_scene(scene_to_load)
		Networking.sync_scene(scene_to_load)

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_RetryButton_focus_entered():
	speaker.play_sound("retry")

func _on_BackButton_focus_entered():
	speaker.play_sound("back")
