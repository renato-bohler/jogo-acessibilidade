extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	# Focus the IP input
	$InputIPAddress/Menu/Input/IPAddress.grab_focus()
	
	# Connect every press event to change scene accordingly
	for button in $InputIPAddress/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

	# Connect every press event to change scene accordingly
	for button in $Connecting/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)
	
func _on_ConnectButton_pressed():
	$InputIPAddress.hide()
	$Connecting/Menu/LoadingContainer/Loading/AnimationPlayer.play("Rotate")
	$Connecting/Menu/Buttons/BackButton.grab_focus()
	$Connecting.show()
	_connect($InputIPAddress/Menu/Input/IPAddress.text)

func _connect(ipAddress):
	print("TODO: connect to the IP address: %s" % ipAddress)