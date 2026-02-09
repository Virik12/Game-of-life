extends TileMapLayer

var GAMESIZEX = Ustawienia.GAMESIZEX
var GAMESIZEY = Ustawienia.GAMESIZEY
var CHANCE = Ustawienia.CHANCE
var GAMESPEED = Ustawienia.GAMESPEED
var BłĘDNY_PROGRAM = Ustawienia.BłĘDNY_PROGRAM

func get_surroundings(Vector):
	var cells = [];
	for j in range(-1,2):
		for i in range(-1,2):
			var cell =Vector2i((Vector.x + i),(Vector.y+j))
			cells.push_front(cell)
	cells.pop_at(cells.size()/2)
	#print(str(cells) + str(cells.size()))
	return cells

func check_surroundings_atlas(cells):
	var how_many_black = 0
	for i in range(cells.size()):
		var temp = get_cell_atlas_coords(cells[i])
		if temp.y == 0:
			how_many_black += 1
	return how_many_black

func check_need_change (Vector:Vector2,how_many_black:int) -> bool:
	var temp = get_cell_atlas_coords(Vector)
	if temp.y == 0:
		if how_many_black < 2 or how_many_black >3:
			return true
		else:
			return false
	else:
		if how_many_black == 3:
			return true
		else:
			return false

func set_cell_blackV2(Vector:Vector2):
	set_cell(Vector,1,Vector2i(0,0))

func set_cell_whiteV2(Vector:Vector2):
	set_cell(Vector,1,Vector2i(0,1))

func set_cell_V3(Vector:Vector3):
	if Vector.z == 3:
		set_cell_blackV2(Vector2i(Vector.x,Vector.y))
	elif Vector.z < 2 or Vector.z > 3:
		set_cell_whiteV2(Vector2i(Vector.x,Vector.y))


func generate_world(SizeX,SizeY,Chance):
	for i in range(1,SizeX + 1):
		for j in range(1,SizeY + 1):
			var rand = randi() % 101
			#print(rand)
			if rand<Chance:
				set_cell_blackV2(Vector2i(i-SizeX/2,j-SizeY/2))
			else:
				set_cell_whiteV2(Vector2i(i-SizeX/2,j-SizeY/2))

func bad_simulation():
	for i in range(1,GAMESIZEX + 1):
		for j in range(1,GAMESIZEY + 1):
			var surroundings_cords=get_surroundings(Vector2i(i-GAMESIZEX/2,j-GAMESIZEY/2))
			var how_many_black=check_surroundings_atlas(surroundings_cords)
			
			if how_many_black == 3:
				set_cell_blackV2(Vector2i(i-GAMESIZEX/2,j-GAMESIZEY/2))
			elif how_many_black < 2 or how_many_black > 3:
				set_cell_whiteV2(Vector2i(i-GAMESIZEX/2,j-GAMESIZEY/2))

func good_simulation():
	var store_data:Array =[]
	var store_data_size:int = 0
	for i in range(1,GAMESIZEX + 1):
		for j in range(1,GAMESIZEY + 1):
			var surroundings_cords=get_surroundings(Vector2i(i-GAMESIZEX/2,j-GAMESIZEY/2))
			var how_many_black=check_surroundings_atlas(surroundings_cords)
			var check_need_change=check_need_change(Vector2i(i-GAMESIZEX/2,j-GAMESIZEY/2),how_many_black)
			if check_need_change == true:
				store_data.push_front(Vector3(i-GAMESIZEX/2,j-GAMESIZEY/2,how_many_black))
				store_data_size +=1
	for i in range(store_data_size):
		set_cell_V3(store_data[i])

func do_simulation():
	if BłĘDNY_PROGRAM==true:
		bad_simulation()
	else:
		good_simulation()

func _ready() -> void:
	generate_world(GAMESIZEX,GAMESIZEY,CHANCE)
	Engine.time_scale = GAMESPEED
	


func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("dalej"):
		do_simulation()
	
	
	if Input.is_action_just_pressed("1 dalej"):
		do_simulation()
	
	if Input.is_action_just_pressed("right_click"):
		var mouse_possition:Vector2
		mouse_possition=get_global_mouse_position()
		mouse_possition=mouse_possition/16
		if mouse_possition.x<0:
			mouse_possition.x -= 1
		if mouse_possition.y<0:
			mouse_possition.y -= 1
		
		var temp:Vector2 = get_cell_atlas_coords(mouse_possition)
		if temp.y == 1:
			set_cell_blackV2(mouse_possition)
		else:
			set_cell_whiteV2(mouse_possition)
