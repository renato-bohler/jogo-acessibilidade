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
	# Connect every press event to change scene accordingly
	for button in $InputIPAddress/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Connect every press event to change scene accordingly
	for button in $Connecting/Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		
	# Connect every press event to change scene accordingly
	for button in $ConnectionError/Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	
	# Focus the IP input
	var focus = $InputIPAddress/Menu/Input/IPAddress
	focus.grab_focus()

func _on_Button_pressed(scene_to_load):
	if (scene_to_load):
		get_tree().change_scene(scene_to_load)

func _on_IPAddress_focus_entered():
	_play_sound("ipaddress")

func _on_ConnectButton_focus_entered():
	_play_sound("start")

func _on_BackButton_focus_entered():
	_play_sound("back")

func _on_IPAddress_text_entered(new_text):
	_transition_to_Connect()

func _on_ConnectButon_presser():
	_transition_to_Connect()

func _transition_to_Connect():
	# Hide other nodes
	$InputIPAddress.hide()
	$ConnectionError.hide()
	
	# Prepare Connecting node
	$Connecting/Menu/LoadingContainer/Loading/AnimationPlayer.play("Rotate")
	$Connecting/Menu/Buttons/BackButton.grab_focus()
	$Connecting.show()
	
	# Play sounds
	_play_sound("connecting")
	yield(speaker, "finished")
	_play_sound("abort")
	yield(speaker, "finished")
	_play_sound("tic_toc", "ogg")
	
	# Connect to the provided IP Address
	_connect($InputIPAddress/Menu/Input/IPAddress.text)

func _connect(ipAddress):
	print("TODO: connect to the IP address: %s" % ipAddress)
	# Only for debugging purposes:
	$Timer.connect("timeout", self, "_transition_to_ConnectionError")
	$Timer.set_wait_time(3)
	$Timer.start()

func _transition_to_ConnectionError():
	# Stop tic-toc
	speaker.stop()
	
	# Hide other nodes
	$InputIPAddress.hide()
	$Connecting.hide()
	
	# Prepare ConnectionError node
	$ConnectionError.show()
	
	# Focus the retry button
	var focus = $ConnectionError/Menu/CenterRow/Buttons/RetryButton
	focus.grab_focus()
	
	# Play sounds
	_play_sound("connectionerror_text")
	yield(speaker, "finished")
	if get_focus_owner() == focus:
		_play_sound("retry")

func _on_RetryButton_focus_entered():
	_play_sound("retry")

func _on_RetryButton_pressed():
	_transition_to_Connect()
