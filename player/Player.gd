extends Node

const DEFAULT_MOVE_SPEED = 300
const ROTATION_STEP_DEGREES = 15

class_name Player

enum RotationDirection {
	ROTATE_CLOCKWISE,
	ROTATE_COUNTER_CLOCKWISE
	}

var movement_direction
var movement
var desired_movement
var rotation: int
var desired_rotation
var move_speed

func _init():
	self.movement = Vector2()
	self.desired_movement = Vector2()
	self.rotation = 0
	self.desired_rotation = 0
	self.move_speed = DEFAULT_MOVE_SPEED
	self.movement_direction = PlayerActions.ActionDirection.NO_ACTION
	
	
func walk():
	self._handle_simpler_rotation()
	if self.desired_rotation != self.rotation:
		self.movement.x = 0
		self.movement.y = 0
		return
	
	self.movement.x = self.desired_movement.x
	self.movement.y = self.desired_movement.y
	
func _handle_simpler_rotation():
	self.rotation = self.desired_rotation

func _handle_rotation():
	if self.rotation == self.desired_rotation:
		return
	
	var rotation_direction = self._get_rotation_direction()
	if rotation_direction == RotationDirection.ROTATE_CLOCKWISE:
		self._rotate_clockwise()
		return
		
	self._rotate_counter_clockwise()
	
func _rotate_clockwise():
	var new_rotation = self.rotation + self.ROTATION_STEP_DEGREES
	if new_rotation == 360:
		self.rotation = 0;
		return
		
	if new_rotation > 360:
		new_rotation = new_rotation - 360
		
	self.rotation = new_rotation
	
func _rotate_counter_clockwise():
	var new_rotation = self.rotation - self.ROTATION_STEP_DEGREES
		
	if new_rotation < 0:
		new_rotation = 360 - abs(new_rotation)
		
	self.rotation = new_rotation

func _get_rotation_direction():
	if self.desired_rotation > self.rotation and self.desired_rotation - self.rotation > 180:
		return RotationDirection.ROTATE_COUNTER_CLOCKWISE
		
	if self.desired_rotation > self.rotation and self.desired_rotation - self.rotation <= 180:
		return RotationDirection.ROTATE_CLOCKWISE
		
	if self.desired_rotation < self.rotation and self.rotation - self.desired_rotation <= 180:
		return RotationDirection.ROTATE_COUNTER_CLOCKWISE
	
	if self.desired_rotation < self.rotation and self.rotation - self.desired_rotation > 180:
		return RotationDirection.ROTATE_CLOCKWISE
		
	return RotationDirection.ROTATE_CLOCKWISE