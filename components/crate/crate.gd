extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var direction= Vector2.DOWN
export (int) var speed= 0
var is_breaking = false
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("SceneScript.change_allowed", self, "reset_box")

func _physics_process(delta):
	var movement= direction * speed * delta
	var collide = move_and_collide(movement)
	if (collide != null) and not is_breaking:
		break_creat()

func delete_crate():
	#get_parent().get_parent().remove_child(get_parent())
	get_parent().queue_free()

func break_creat():
	is_breaking = true
	speed= 0
	$AnimatedSprite.play("break")
	get_node("AnimatedSprite").connect("animation_finished", self, "break_finisched")
	
func break_finisched():
	delete_crate()
