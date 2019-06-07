extends PlayerBody

var player: Player
var player_body: KinematicBody2D
var seeing_player_position: Vector2
var seeing_player_rotation: int
var seeing_player_position_updated: bool

func _init(player_body: KinematicBody2D):
	self.player_body = player_body
	self.player = preload("res://player/Player.gd").new()
	Networking.connect("new_position", self, "on_viewing_new_position")

func execute(delta):
	var indication_action: ListenerPlayerActions = self.player_body.listenerPlayerIndication.get_indication()
	Networking.send_warning(indication_action)
	self.update_position(delta)
	self.seeing_player_position_updated = false
	
func on_viewing_new_position(pos: Vector2, rotation: int):
	self.seeing_player_position = pos
	self.seeing_player_rotation = rotation
	self.seeing_player_position_updated = true

func update_position(delta):
	if self.seeing_player_position_updated == false:
		return
		
	self.update_player()
	self.update_player_body_state(delta)
	
func update_player():
	self.player_body.position = self.seeing_player_position
	self.player.rotation = self.seeing_player_rotation

func update_player_body_state(delta):
	var move_vec = self.player.movement.normalized()
	self.player_body.move_and_collide(move_vec * self.player.move_speed * delta)
	self.player_body.global_rotation_degrees = self.player.rotation