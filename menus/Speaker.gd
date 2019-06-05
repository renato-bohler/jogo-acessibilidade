extends AudioStreamPlayer

onready var speaker = get_node("/root/Speaker")
onready var sound_navigation = get_node("/root/SoundNavigation/Toggle")

func play_sound(filename):
	if (sound_navigation.pressed):
		var vstream = load("res://assets/sounds/menus/%s.ogg" % filename)
		speaker.set_stream(vstream)
		speaker.play()
	else:
		yield(get_tree().create_timer(0.1), "timeout")
		emit_signal("finished")