extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#export var colors= {"white":Color("#FFFFFF"),"red":Color("#F52300"),"blue":Color("#009CF5"),"orange":Color("#FBBB0D"),"green":Color("#9CF500")}
export var speed= 60

var Crate = load("res://components/crate/crate.tscn")

#var smeg = preload("res://scenes/SceneSkript.gd")
var colors = SceneSkript.colors

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2.0), "timeout")
	for n in SceneSkript.boxes:
		creat_box()
		yield(get_tree().create_timer(2.0), "timeout")
		

func _unhandled_input(ev): #inherited from control
	if ev is InputEventKey:
		if ev.pressed and ev.scancode == KEY_S:
			creat_box()

func creat_box():
	var crate_instance = Crate.instance()
	crate_instance.position = Vector2(0,0)
	var rnd_num = randi() % 4
	if rnd_num == 0:
		crate_instance.modulate= colors.white
	elif rnd_num == 1:
		crate_instance.modulate= colors.blue
	elif rnd_num == 2:
		crate_instance.modulate= colors.red
	elif rnd_num == 3:
		crate_instance.modulate= colors.green
	crate_instance.get_child(0).speed= speed
	add_child(crate_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
