extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.name == "PlayerBody"):
			get_owner().get_node("PlayerBody").hasKey = true
			get_owner().get_node("TileMapLvl2/Key").visible = false
			