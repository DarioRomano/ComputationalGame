extends Node2D

export var count= 0
var safed_count= 0
export var color=Color.white
signal goal_reached
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.self_modulate=color
	$Label.text=String(count)
	if get_tree().get_root().get_node_or_null("./Node2D2/CanvasLayer/MenuWithButtons") != null:
		get_tree().get_root().get_node("./Node2D2/CanvasLayer/MenuWithButtons").connect("reset_signal", self, "_on_MenuWithButtons_reset_signal")
	get_node("Label").rect_rotation= -rotation_degrees
	safed_count= count

func reduce_count():
	if not count==0:
		count-=1
		$Label.text=String(count)
		if count==0:
			emit_signal("goal_reached")

func _on_MenuWithButtons_reset_signal():
	count= safed_count
	$Label.text=String(count)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
