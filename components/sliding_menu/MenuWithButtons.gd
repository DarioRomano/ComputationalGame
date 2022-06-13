extends Control

#This bool will help us track if the menu is on the players screen
var IsMenuShown = true
signal reset_signal

func _on_HideMenu_button_up(): #Signal
	#Also keyboard navigation by avoiding bugs
	#Last button pressed is grabed so pressing Enter will activate it
	if (IsMenuShown == false):
		$MwBAnimator.play("Slide In")
		IsMenuShown = true
		get_node("PanelContainer/HBoxContainer/ButtonAndText2/HideMenu").text=">"
	else:
		$MwBAnimator.play("MenuSlideOut")
		IsMenuShown = false
		get_node("PanelContainer/HBoxContainer/ButtonAndText2/HideMenu").text="<"
		
	#You could also have relseased the grab using
	#$PanelContainer/ButtonAndText/HBoxContainer5/HideMenu.release_focus()
	#But that is considered bad design, as it removes a fallback input on devices that need it

func _unhandled_input(ev): #inherited from control
	if ev is InputEventKey:
		if ev.pressed and ev.scancode == KEY_I:
			#also support I for hiding menu
			if (IsMenuShown == false):
				$MwBAnimator.play("Slide In")
				IsMenuShown = true
			else:
				$MwBAnimator.play("MenuSlideOut")
				IsMenuShown = false


"""If you plan to have many menues you can either plan how to grab focus for each,
I used the animator to hide things, this way the buttons can't be selected.
If you do hide the whole menu, you should allow people to change the Invintory key, 
here is a example using ui_cancel that you can change in Project-> Project Settings-> Input Map"""

func _process(delta): #inherited from node
	if Input.is_action_just_pressed("ui_cancel"):
		if (IsMenuShown == false):
			$MwBAnimator.play("Slide In")
			IsMenuShown = true
		else:
			$MwBAnimator.play("MenuSlideOut")
			IsMenuShown = false

func _on_Start_Button_button_up():
	SceneSkript.change_allowed= false
	get_parent().get_parent().get_node("SpawnTimer").start(1)

func _on_Stop_Run_button_up():
	SceneSkript.change_allowed= true
	get_parent().get_parent().get_node("SpawnTimer").stop()
	emit_signal("reset_signal")

func _on_Main_Menu_button_up():
	SceneSkript.level= 0
	SceneSkript.change_allowed= true
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_Button_button_up():
	pass # Replace with function body.
