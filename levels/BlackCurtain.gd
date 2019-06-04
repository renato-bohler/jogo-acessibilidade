extends ColorRect

func _ready():
	if (SceneChanger.hearing_mode):
		self.show()
	else:
		self.hide()