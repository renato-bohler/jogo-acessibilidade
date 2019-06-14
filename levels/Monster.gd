extends Area2D

var death_scene = "res://menus/play/Death.tscn"
var changed = false

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.name == "PlayerBody" and not changed):
			SceneChanger.change_scene(death_scene)
			Networking.sync_scene(death_scene)
			changed = true
			body.isDead = true