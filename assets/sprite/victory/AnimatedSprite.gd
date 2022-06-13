extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_finished_level():
	self.visible = true
	yield(get_tree().create_timer(4.0), "timeout")
	if SceneSkript.level== 1:
		get_tree().change_scene("res://levels/Level2.tscn")
	elif SceneSkript.level== 2:
		get_tree().change_scene("res://scenes/MainMenu.tscn")

	
