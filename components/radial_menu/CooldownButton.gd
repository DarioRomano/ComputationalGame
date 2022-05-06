extends TextureButton

func _ready():
	$Label.hide()
	connect("pressed",self.get_parent().get_parent(),"_on_StartButton_pressed")
	connect("pressed",self.get_parent().get_parent(),"add_animation",[self.self_modulate])
	set_process(false)
