extends Camera2D

export (NodePath) var target
var target_return_enabled = true
var target_return_rate = 0.02
var min_zoom = 1
var max_zoom = 2
var zoom_sensitivity = 10
var zoom_speed = 0.05

var events = {}
var last_drag_distance = 0


func _process(delta):
	if target and target_return_enabled and events.size() == 0:
		position = lerp(position, get_node(target).position, target_return_rate)


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_DOWN:
			var new_zoom = clamp(zoom.x * 1.05, min_zoom, max_zoom)
			zoom = Vector2.ONE * new_zoom
			# call the zoom function
			# zoom out
		if event.button_index == BUTTON_WHEEL_UP:
			var new_zoom = clamp(zoom.x * 0.95, min_zoom, max_zoom)
			zoom = Vector2.ONE * new_zoom
		# call the zoom function
	if event is InputEventScreenTouch:
		if event.pressed:
			events[event.index] = event
		else:
			events.erase(event.index)

	if event is InputEventScreenDrag:
		events[event.index] = event
		if events.size() == 1:
			position -= event.relative.rotated(rotation) * zoom.x
		elif events.size() == 2:
			var drag_distance = events.values()[0].position.distance_to(events.values()[1].position)
			if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
				var new_zoom = (1 + zoom_speed) if drag_distance < last_drag_distance else (1 - zoom_speed)
				new_zoom = clamp(zoom.x * new_zoom, min_zoom, max_zoom)
				zoom = Vector2.ONE * new_zoom
				last_drag_distance = drag_distance
