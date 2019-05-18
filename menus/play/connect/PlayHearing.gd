extends Control

func _play_sound(filename, type = "wav"):
	var vstream = load("res://assets/sounds/menus/{filename}.{type}".format({"filename": filename, "type": type}))
	$Speaker.set_stream(vstream)
	$Speaker.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect every press event to change scene accordingly
	for button in $InputIPAddress/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Connect every press event to change scene accordingly
	for button in $Connecting/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Focus the IP input
	var focus = $InputIPAddress/Menu/Input/IPAddress
	focus.grab_focus()

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)

func _on_IPAddress_focus_entered():
	_play_sound("ipaddress")

func _on_ConnectButton_focus_entered():
	_play_sound("start")

func _on_BackButton_focus_entered():
	_play_sound("back")

func _on_ConnectButton_pressed():
	$InputIPAddress.hide()
	$Connecting/Menu/LoadingContainer/Loading/AnimationPlayer.play("Rotate")
	$Connecting/Menu/Buttons/BackButton.grab_focus()
	$Connecting.show()
	_play_sound("connecting")
	yield($Speaker, "finished")
	_play_sound("abort")
	yield($Speaker, "finished")
	_play_sound("tic_toc", "ogg")
	_connect($InputIPAddress/Menu/Input/IPAddress.text)

func _connect(ipAddress):
	print("TODO: connect to the IP address: %s" % ipAddress)
