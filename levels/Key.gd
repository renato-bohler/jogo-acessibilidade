extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if (body.name == "PlayerBody" and not body.hasKey):
			get_owner().get_node("PlayerBody").hasKey = true
			get_owner().get_node("TileMapLvl2/Key").visible = false
			get_owner().get_node("TileMapLvl2/Door/AudioStreamPlayer2D").play(0)
			get_owner().get_node("TileMapLvl2/Door/Sprite").texture = load("res://assets/door-left.png")
			get_owner().get_node("TileMapLvl2/Door/Sprite2").texture = load("res://assets/door-right.png")
			break