extends KinematicBody2D

class_name PlayerBody

var mechanics_instance
var player_animation
var player_mode
onready var listenerPlayerIndication = $ListenerPlayerIndication
onready var animation_sprite = get_node("PlayerVisionMoveAnimation")
onready var camera_hearing = get_node("CameraHearing")
var isDead
var hasKey

func _ready():
	isDead = false
	hasKey = false
	self.mechanics_instance = load("res://player/mechanics.gd").new()
	self.player_animation = load("res://player/PlayerAnimation.gd").new()
	
	if (SceneChanger.hearing_mode):
		player_mode = load("res://player/PlayerHearing.gd").new(self)
	elif (SceneChanger.hearing_mode == false):
		player_mode = load("res://player/PlayerSeeing.gd").new(self)
	
	yield(get_tree(), "idle_frame")
	get_tree().call_group("monster", "set_player", self)
	
func _physics_process(delta):
	if (not isDead):
		player_mode.execute(delta)
