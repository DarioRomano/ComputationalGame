extends TextureButton

export var radius = 80
export var speed = 0.25
export var negated=false
#export var colors= {"white":Color("#FFFFFF"),"red":Color("#F52300"),"blue":Color("#009CF5"),"orange":Color("#FBBB0D"),"green":Color("#9CF500")}
export var current_color = Color("#FFFFFF")

signal radial_showing

var base_scale=Vector2(1,1)
var icon_factor=1
var num
var active = false
var holding=false
var expanded=false

var _normal_texture=load("res://assets/sprite/chooser_buttons/chooser_button.png")
var _crossed_texture=load("res://assets/sprite/chooser_buttons/chooser_button_neg.png")

func _ready():
	current_color=SceneSkript.colors.white
	add_wobble_animation()
	$Buttons.hide()
	self.rect_scale=base_scale
	num = $Buttons.get_child_count()
	var count=0
	for b in $Buttons.get_children():
		b.rect_position = Vector2(0,0)
		var c
		match count:
			0:c=SceneSkript.colors.white
			1:c=SceneSkript.colors.red
			2:c=SceneSkript.colors.blue
			3:c=SceneSkript.colors.green
		b.get_node("Sprite").self_modulate=c
		count=count+1
	connect("button_up", self, "_on_StartButton_released")
	connect("button_down", self,"_onStartButton_pushed")

func add_wobble_animation():
	var animation = Animation.new()
	var track_index = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(track_index, "./MainButton:scale")
	animation.track_insert_key(track_index, 0, base_scale*icon_factor)
	animation.track_insert_key(track_index, 0.2,base_scale*1.2*icon_factor)
	animation.track_insert_key(track_index, 0.45,base_scale*.85*icon_factor)
	animation.track_insert_key(track_index, 0.5, base_scale*icon_factor)
	$AnimationPlayer.add_animation("Wobble",animation)

func add_animation(button):
	var sprite=self.get_node("./MainButton")
	var target=button.get_node("Sprite").self_modulate
	$Tween.interpolate_property(sprite,"self_modulate",sprite.self_modulate,target,0.2,Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	$AnimationPlayer.play("Wobble")
	current_color=target

func show_menu():
	emit_signal("radial_showing",self)
	$Buttons.show()
	#var spacing = TAU / num
	var spacing = PI / (num-1)
	for b in $Buttons.get_children():
		var a = spacing * b.get_position_in_parent() - PI / 2
		var dest = b.rect_position + Vector2(radius, 0).rotated(a)
		$Tween.interpolate_property(b, "rect_position", Vector2(0,0),
				dest, speed, Tween.TRANS_BACK, Tween.EASE_OUT)
		$Tween.interpolate_property(b, "rect_scale", Vector2(0,0),
				Vector2.ONE, speed, Tween.TRANS_LINEAR)	
	$Tween.start()
	expanded=true


func hide_menu(wobble):
	if expanded:
		for b in $Buttons.get_children():
			$Tween.interpolate_property(b, "rect_position", b.rect_position,
					Vector2(0,0), speed, Tween.TRANS_BACK, Tween.EASE_IN)
			$Tween.interpolate_property(b, "rect_scale", null,
					Vector2(0,0), speed, Tween.TRANS_LINEAR)
		$Tween.start()	
		#if wobble:
		$AnimationPlayer.play("Wobble")
		expanded=false


func _on_StartButton_released():
	$HoldTimer.stop()
	if not holding:
		disabled = true
		if active:
			hide_menu(true)
		else:
			show_menu()
	holding=false

func _onStartButton_pushed():
	$HoldTimer.start(.5)

func _on_Tween_tween_all_completed():
	disabled = false
	active = not active
	if not active:
		$Buttons.hide()

func _on_HoldTimer_timeout():
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
		$MainButton.texture=_crossed_texture
	else:
		$MainButton.texture=_normal_texture


func _on_Down_radial_showing(s):
	if s!=self:
		hide_menu(false)


func _on_Left_radial_showing(s):
	if s!=self:
		hide_menu(false)


func _on_Right_radial_showing(s):
	if s!=self:
		hide_menu(false)


func _on_Up_radial_showing(s):
	if s!=self:
		hide_menu(false)
