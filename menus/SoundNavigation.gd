extends CheckButton

onready var speaker = get_node("/root/Speaker")

func _on_SoundNavigation_toggled(button_pressed):
	speaker.stop()
	if (button_pressed):
		speaker.play_sound("unmute")
