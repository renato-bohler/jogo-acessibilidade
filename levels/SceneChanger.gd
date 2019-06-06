extends CanvasLayer

signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var black = $Control/Black

# Determines if the player is playing on vision or hearing mode
var hearing_mode = true;

func change_scene(path, delay=0.2):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("Fade Out")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("Fade Out")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")

func set_hearing_mode(hearing):
	hearing_mode = hearing