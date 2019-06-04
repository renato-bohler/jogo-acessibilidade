extends Camera2D

func _ready():
	if (SceneChanger.hearing_mode):
		self.current = true
	else:
		self.current = false