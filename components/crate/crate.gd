extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var direction= Vector2.DOWN
export (int) var speed= 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func _physics_process(delta):
	if(Input.get_action_strength("ui_down")!=0):
		speed=200
	var movement= Vector2.ZERO  #11816118 if no possible direction -> movment Zero
	if(direction != null):
		movement= direction * speed * delta
	else:
		movement= Vector2.ZERO
	var collision = move_and_collide(movement)
	if collision != null and collision.collider.name=="MachineBody":
		direction=calculate_direction(collision.collider)
	if collision != null and collision.collider.name=="GoalBody":
		queue_free()

func calculate_direction(c):
	var color=get_parent().modulate
	var left=c.get_node("Left")
	var down=c.get_node("Down")
	var right=c.get_node("Right")
	var up=c.get_node("Up")
	print("color is ",color)
	if((left.current_color.is_equal_approx(color) and !left.negated) or (not left.current_color.is_equal_approx(color) and left.negated)):
		return Vector2.LEFT
	elif((down.current_color.is_equal_approx(color) and !down.negated) or (not down.current_color.is_equal_approx(color) and down.negated)):
		return Vector2.DOWN
	elif((right.current_color.is_equal_approx(color) and !right.negated) or (not right.current_color.is_equal_approx(color) and right.negated)):
		return Vector2.RIGHT
	elif((up.current_color.is_equal_approx(color) and !up.negated) or (not up.current_color.is_equal_approx(color) and up.negated)):
		return Vector2.UP

func set_speed():
	speed = 200
