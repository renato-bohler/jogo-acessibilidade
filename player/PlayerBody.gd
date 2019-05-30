extends KinematicBody2D

var mechanics_instance
var player
var player_animation

onready var listenerPlayerIndication = get_node("ListenerPlayerIndication")
onready var animation_sprite = get_node("Sprite")


func _ready():
	player = preload("res://player/Player.gd").new()
	mechanics_instance = load("res://player/mechanics.gd").new()
	player_animation = load("res://player/PlayerAnimation.gd").new()
	yield(get_tree(), "idle_frame")
	get_tree().call_group("monster", "set_player", self)
	
func _physics_process(delta):
	player = mechanics_instance.handle_movement(player)
	player_animation.handle_animation(player, animation_sprite)
	listenerPlayerIndication.handle_indication()
	var move_vec = player.movement.normalized()
	move_and_collide(move_vec * player.move_speed * delta)
	
	global_rotation_degrees = player.rotation
