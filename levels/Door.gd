extends Area2D

export(String, FILE, "*.tscn") var world_scene

var changed = false

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.name == "PlayerBody" and get_owner().get_node("PlayerBody").hasKey and not changed):
			SceneChanger.change_scene(world_scene)
			Networking.sync_scene(world_scene)
			changed = true
			