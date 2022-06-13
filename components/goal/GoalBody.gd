extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_GoalBody_body_entered(body):
	if get_parent().color.is_equal_approx(SceneSkript.colors.white) or get_parent().color.is_equal_approx(body.get_parent().modulate):
		var a= get_parent().modulate
		var b= body.get_parent().modulate
		body.delete_crate()
		get_parent().reduce_count()
	else:
		body.break_creat()
