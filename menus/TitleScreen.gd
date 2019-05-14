extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	# Focus the first button on the menu
	$Menu/CenterRow/Buttons/PlayButton.grab_focus()
	
	# Connect every press event to change scene accordingly
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)