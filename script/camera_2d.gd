extends Camera2D

const ZOOM_SPEED = 0.1;


func do_zoom(input:int) -> void:
	if input == 0: 
		input = -1
	zoom += Vector2(input*ZOOM_SPEED,input*ZOOM_SPEED)


func _input(event: InputEvent) -> void:
	
	var zoom_direction = Input.get_axis("zoom out","zoom in")
	var click_position:Vector2
	
	if zoom_direction:
		do_zoom(zoom_direction)
	
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		position = click_position
