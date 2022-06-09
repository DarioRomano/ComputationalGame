extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var direction= Vector2.DOWN
export (int) var speed= 0
# Called when the node enters the scene tree for the first time.
#func _ready():
#	direction=Vector2.DOWN
	
	
func _physics_process(delta):
	var movement= direction * speed * delta
	move_and_collide(movement)

func delete_crate():
	queue_free()

func break_creat():
	speed= 0
	$AnimatedSprite.play("break")
	connect("animation_finished", self, "break_finisched")
	
func break_finisched():
	delete_crate()
