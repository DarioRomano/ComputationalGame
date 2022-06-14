extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var boxList_down = []
var boxList_up=[]
var boxList_left = []
var boxList_right=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().get_node("./Node2D2/SpawnTimer").connect("timeout", self, "_on_SpawnTimer_timeout")
	get_tree().get_root().get_node("./Node2D2/CanvasLayer/MenuWithButtons").connect("reset_signal", self, "_on_MenuWithButtons_reset_signal")
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
		if body.direction == Vector2.UP:
			boxList_up.append(box)
		elif body.direction ==Vector2.DOWN:
			boxList_down.append(box)
		elif body.direction == Vector2.LEFT:
			boxList_left.append(box)
		elif body.direction == Vector2.RIGHT:
			boxList_right.append(box)
		body.delete_crate()
	
func _unhandled_input(ev): #inherited from control
	if ev is InputEventKey:
		if ev.pressed and ev.scancode == KEY_D:
			boxList_down.remove(0)
			boxList_up.remove(0)
			boxList_right.remove(0)
			boxList_left.remove(0)
			print("removed")

func _on_SpawnTimer_timeout():
	if not boxList_down.empty():
		get_node("SpDown").spawncrate(Vector2.DOWN, rotate_color(boxList_down[0]))
		boxList_down.remove(0)
	if not boxList_up.empty():
		get_node("SpUp").spawncrate(Vector2.UP, rotate_color(boxList_up[0]))
		boxList_up.remove(0)
	if not boxList_left.empty():
		get_node("SpLeft").spawncrate(Vector2.LEFT, rotate_color(boxList_left[0]))
		boxList_left.remove(0)
	if not boxList_right.empty():
		get_node("SpRight").spawncrate(Vector2.RIGHT, rotate_color(boxList_right[0]))
		boxList_right.remove(0)

func rotate_color(col:Color):
	if col.is_equal_approx(SceneSkript.colors.red):
		return SceneSkript.colors.blue
	elif col.is_equal_approx(SceneSkript.colors.blue):
		return SceneSkript.colors.green
	elif col.is_equal_approx(SceneSkript.colors.green):
		return SceneSkript.colors.orange
	elif col.is_equal_approx(SceneSkript.colors.orange):
		return SceneSkript.colors.red

func _on_MenuWithButtons_reset_signal():
	for ch in get_children():
		if (ch.get_node_or_null("RigidBody2D")!= null) and ch.get_node("RigidBody2D").has_method("delete_crate"):
			ch.get_node("RigidBody2D").delete_crate()
	boxList_down.clear()
	boxList_up.clear()
	boxList_left.clear()
	boxList_right.clear()
