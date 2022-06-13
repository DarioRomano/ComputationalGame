extends Node2D

signal victory
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func goal_finished():
	var all_finished=true
	for g in get_children():
		if not g.finished:
			all_finished=false
	if all_finished:
		emit_signal("victory")
		get_node("../CanvasLayer/AnimatedSprite").visible=true
		
