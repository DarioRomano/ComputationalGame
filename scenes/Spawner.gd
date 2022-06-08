extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var colors= {"white":Color("#FFFFFF"),"red":Color("#F52300"),"blue":Color("#009CF5"),"orange":Color("#FBBB0D"),"green":Color("#9CF500")}
var Crate = load("res://components/crate/crate.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(ev): #inherited from control
	if ev is InputEventKey:
		if ev.pressed and ev.scancode == KEY_S:
			var crate_instance = Crate.instance()
			crate_instance.position = position - Vector2(0,0)
			var rnd_num = randi() % 4
			if rnd_num == 0:
				crate_instance.modulate= colors.white
			elif rnd_num == 1:
				crate_instance.modulate= colors.blue
			elif rnd_num == 2:
				crate_instance.modulate= colors.red
			elif rnd_num == 3:
				crate_instance.modulate= colors.green
			crate_instance.get_child(0).speed= 200
			add_child(crate_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
