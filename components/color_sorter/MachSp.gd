extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 60
var Crate = load("res://components/crate/crate.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawncrate(direct, color):
	var crate_instance = Crate.instance()
	crate_instance.position = position
	crate_instance.get_child(0).direction = direct
	crate_instance.modulate= color
	crate_instance.get_child(0).speed= speed
	get_parent().add_child(crate_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
