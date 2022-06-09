extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var boxList = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#print("Ready done")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MachineBody_body_entered(body):
	print("Body Now")
	var box = body.get_parent().modulate
	boxList.append(box)
	body.delete_crate()
	
func _unhandled_input(ev): #inherited from control
	if ev is InputEventKey:
		if ev.pressed and ev.scancode == KEY_D:
			boxList.remove(0)
			print("removed")
