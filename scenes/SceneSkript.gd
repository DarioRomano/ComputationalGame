extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var colors= {"white":Color("#FFFFFF"),"red":Color("#F52300"),"blue":Color("#009CF5"),"orange":Color("#FBBB0D"),"green":Color("#9CF500")}
var boxes = 15
var spawnList= [colors.white, colors.red, colors.green, colors.blue, colors.white, colors.red, colors.green, colors.blue,colors.white, colors.red, colors.green, colors.blue,colors.white, colors.red, colors.green, colors.blue]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
