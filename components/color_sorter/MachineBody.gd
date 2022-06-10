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
	var is_child = false
	for ch in get_children():
		if body.get_parent() == ch:
			is_child= true
	if not is_child:
		var box = body.get_parent().modulate
		boxList.append(box)
		body.delete_crate()
	
func _unhandled_input(ev): #inherited from control
	if ev is InputEventKey:
		if ev.pressed and ev.scancode == KEY_D:
			boxList.remove(0)
			print("removed")


func _on_SpawnTimer_timeout():
	var left=get_node("Left")
	var down=get_node("Down")
	var right=get_node("Right")
	var up=get_node("Up")
	if not boxList.empty():
		if ((left.current_color.is_equal_approx(boxList[0]) and not left.negated) or (not left.current_color.is_equal_approx(boxList[0]) and left.negated)):
			get_node("SpLeft").spawncrate(Vector2.LEFT, boxList[0])
		elif((down.current_color.is_equal_approx(boxList[0]) and not down.negated) or (not down.current_color.is_equal_approx(boxList[0]) and down.negated)):
			get_node("SpDown").spawncrate(Vector2.DOWN, boxList[0])
		elif((right.current_color.is_equal_approx(boxList[0]) and not right.negated) or (not right.current_color.is_equal_approx(boxList[0]) and right.negated)):
			get_node("SpRight").spawncrate(Vector2.RIGHT, boxList[0])
		elif((up.current_color.is_equal_approx(boxList[0]) and not up.negated) or (not up.current_color.is_equal_approx(boxList[0]) and up.negated)):
			get_node("SpUp").spawncrate(Vector2.UP, boxList[0])
		
		boxList.remove(0)
