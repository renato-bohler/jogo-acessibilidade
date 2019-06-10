extends PlayerBody

var player: Player
var player_body: KinematicBody2D

func _init(player_body: KinematicBody2D):
	self.player_body = player_body
	self.player = preload("res://player/Player.gd").new()
	Networking.connect("direction_warning", self, "on_hearing_indication")
	self.player_body.camera_hearing.rotating = false
	self.player_body.camera_hearing.current = false

func execute(delta):
	self.player = self.player_body.mechanics_instance.handle_movement(self.player)
	self.player_body.player_animation.handle_animation(self.player, self.player_body.animation_sprite)
	var move_vec = self.player.movement.normalized()
	self.player_body.move_and_collide(move_vec * self.player.move_speed * delta)
	
	self.player_body.global_rotation_degrees = self.player.rotation
	Networking.update_position(self.player_body.position, self.player.rotation)

func on_hearing_indication(action):
	if !is_instance_valid(self.player_body):
		return
	
	if !is_instance_valid(self.player_body.listenerPlayerIndication):
		return
		
	self.player_body.listenerPlayerIndication.show_indication(action)