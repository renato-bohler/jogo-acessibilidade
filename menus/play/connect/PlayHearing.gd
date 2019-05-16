extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	# Animate the loading icon
	$WaitingConnection/Menu/LoadingContainer/Loading/AnimationPlayer.play("Rotate")

	# Focus the back button
	$WaitingConnection/Menu/Buttons/BackButton.grab_focus()
	
	# Connect every press event to change scene accordingly
	for button in $WaitingConnection/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)