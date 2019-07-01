extends Node2D

export(String) var monster_audio

var death_scene = "res://menus/play/Death.tscn"
var changed = false

func _ready():
	if (SceneChanger.hearing_mode):
		var vstream = load("res://assets/sounds/monster/monster_%s.ogg" % monster_audio)
		$Voice.set_stream(vstream)
		$Voice.play()

func _physics_process(delta):
	var bodies = $Hitbox.get_overlapping_bodies()
	for body in bodies:
		if (body.name == "PlayerBody" and not changed):
			SceneChanger.change_scene(death_scene)
			Networking.sync_scene(death_scene)
			changed = true
			body.isDead = true