extends CanvasLayer

signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var black = $Control/Black

# Determines if the player is playing on vision or hearing mode
var hearing_mode = true;

func _ready():
	Networking.connect("sync_scene", self, "_on_sync_scene")
	
func _on_sync_scene(scene):
	change_scene(scene)

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
	if hearing:
		SoundNavigation.get_node("BackgroundMusic").set_volume_db(-40)
	else:
		SoundNavigation.get_node("BackgroundMusic").set_volume_db(-25)