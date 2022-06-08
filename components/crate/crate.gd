extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var direction= Vector2.DOWN
export var speed= 0
# Called when the node enters the scene tree for the first time.
func _ready():
	direction=Vector2.DOWN
	
	
func _physics_process(delta):
	if(Input.get_action_strength("ui_down")!=0):
		speed=200
	var movement= direction * speed * delta
	var collision = move_and_collide(movement)
	if collision != null and collision.collider.name=="MachineBody":
		direction=calculate_direction(collision.collider)

func calculate_direction(c):
	var color=get_parent().modulate
	var left=c.get_node("Left")
	var down=c.get_node("Down")
	var right=c.get_node("Right")
	var up=c.get_node("Up")
	print("color is ",color)
	if((left.current_color==color and !left.negated) or (left.current_color!=color and left.negated)):
		return Vector2.LEFT
	elif((down.current_color==color and !down.negated) or (down.current_color!=color and down.negated)):
		return Vector2.DOWN
	elif((right.current_color==color and !right.negated) or (right.current_color!=color and right.negated)):
		return Vector2.RIGHT
	elif((up.current_color==color and !up.negated) or (up.current_color!=color and up.negated)):
		return Vector2.UP
