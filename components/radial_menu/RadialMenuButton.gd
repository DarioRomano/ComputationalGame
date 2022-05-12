extends TextureButton

export var radius = 120
export var speed = 0.25
export var negated=false

var base_scale=Vector2(0.25,0.25)
var num
var active = false
var holding=false

var _normal_texture=load("res://assets/icons/colors/white_circlex512.png")
var _crossed_texture=load("res://assets/icons/colors/white_circle_crossedx512.png")

func _ready():
	add_wobble_animation()
	$Buttons.hide()
	num = $Buttons.get_child_count()
	for b in $Buttons.get_children():
		b.rect_position = rect_position
	connect("button_up", self, "_on_StartButton_released")
	connect("button_down", self,"_onStartButton_pushed")

func add_wobble_animation():
	var animation = Animation.new()
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, ".:rect_scale")
	animation.track_insert_key(track_index, 0, base_scale)
	animation.track_insert_key(track_index, 0.2,base_scale*1.2)
	animation.track_insert_key(track_index, 0.45,base_scale*.85)
	animation.track_insert_key(track_index, 0.5, base_scale)
	$AnimationPlayer.add_animation("Wobble",animation)
	print(self.rect_scale)

func add_animation(col):
	$Tween.interpolate_property(self,"self_modulate",self.self_modulate,col,0.2,Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	$AnimationPlayer.play("Wobble")

func show_menu():
	print("showing")
	$Buttons.show()
	var spacing = TAU / num
	for b in $Buttons.get_children():
		var a = spacing * b.get_position_in_parent() - PI / 2
		var dest = b.rect_position + Vector2(radius, 0).rotated(a)
		$Tween.interpolate_property(b, "rect_position", b.rect_position,
				dest, speed, Tween.TRANS_BACK, Tween.EASE_OUT)
		$Tween.interpolate_property(b, "rect_scale", base_scale*.5,
				base_scale*Vector2.ONE, speed, Tween.TRANS_LINEAR)	
	$Tween.start()


func hide_menu():
	print("hiding")
	for b in $Buttons.get_children():
		$Tween.interpolate_property(b, "rect_position", b.rect_position,
				rect_position, speed, Tween.TRANS_BACK, Tween.EASE_IN)
		$Tween.interpolate_property(b, "rect_scale", null,
				base_scale*.5, speed, Tween.TRANS_LINEAR)
	$Tween.start()	
	$AnimationPlayer.play("Wobble")


func _on_StartButton_released():
	$HoldTimer.stop()
	print("release")
	print(self.rect_scale)
	if not holding:
		disabled = true
		if active:
			hide_menu()
		else:
			show_menu()
	holding=false

func _onStartButton_pushed():
	print("push")
	$HoldTimer.start(.5)

func _on_Tween_tween_all_completed():
	disabled = false
	active = not active
	if not active:
		$Buttons.hide()

func _on_HoldTimer_timeout():
	print("hold")
	$HoldTimer.stop()
	holding=true	
	$AnimationPlayer.play("Wobble")
	if(negated):
		negated=false
		change_crosslines(false)
	else:
		negated=true		
		change_crosslines(true)

func change_crosslines(visible):
	if visible:
		self.texture_normal=_crossed_texture
	else:
		self.texture_normal=_normal_texture
