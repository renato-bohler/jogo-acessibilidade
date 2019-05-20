extends AudioStreamPlayer

onready var speaker = get_node("/root/Speaker")
onready var sound_navigation = get_node("/root/SoundNavigation")

func play_sound(filename):
	if (sound_navigation.pressed):
		var vstream = load("res://assets/sounds/menus/%s.ogg" % filename)
		speaker.set_stream(vstream)
		speaker.play()
	else:
		emit_signal("finished")