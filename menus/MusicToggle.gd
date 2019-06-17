extends CheckButton

onready var musicSpeaker = get_node("/root/SoundNavigation/BackgroundMusic")

func _on_MusicToggle_toggled(button_pressed):
	if (button_pressed):
		musicSpeaker.play()
	else:
		musicSpeaker.stop()
