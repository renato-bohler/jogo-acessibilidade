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
	self.player_body.camera_hearing.rotating = true
	self.player_body.camera_hearing.current = true

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
	
func update_player():
	self.player_body.position = self.seeing_player_position
	self.player_body.global_rotation_degrees = self.player.rotation
	self.player.rotation = self.seeing_player_rotation