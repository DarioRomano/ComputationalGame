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
		if should_I_go_in(left):
			get_node("SpLeft").spawncrate(Vector2.LEFT, boxList[0])
		elif should_I_go_in(down):
			get_node("SpDown").spawncrate(Vector2.DOWN, boxList[0])
		elif should_I_go_in(right):
			get_node("SpRight").spawncrate(Vector2.RIGHT, boxList[0])
		elif should_I_go_in(up):
			get_node("SpUp").spawncrate(Vector2.UP, boxList[0])
		
		boxList.remove(0)
		
func should_I_go_in(dir):
	return (((dir.current_color.is_equal_approx(boxList[0]) or dir.current_color.is_equal_approx(SceneSkript.colors.white)) and not dir.negated) or (not (dir.current_color.is_equal_approx(boxList[0]) or dir.current_color.is_equal_approx(SceneSkript.colors.white)) and dir.negated))
