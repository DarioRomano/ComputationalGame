extends TextureButton

func _ready():
	connect("pressed",self.get_parent().get_parent(),"_on_StartButton_released")
	connect("pressed",self.get_parent().get_parent(),"add_animation",[self])
	set_process(false)
