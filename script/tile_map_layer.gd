extends TileMapLayer

const GAMESIZEX = 64
const GAMESIZEY = 48
const CHANCE = 20
const GAMESPEED = 1
var BłĘDNY_PROGRAM

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

func simulation():
	var store_data:Array =[]
	for i in range(1,GAMESIZEX + 1):
		for j in range(1,GAMESIZEY + 1):
			var surroundings_cords=get_surroundings(Vector2i(i-GAMESIZEX/2,j-GAMESIZEY/2))
			var how_many_black=check_surroundings_atlas(surroundings_cords)
			store_data.push_front(Vector3(i-GAMESIZEX/2,j-GAMESIZEY/2,how_many_black))
	for i in range(GAMESIZEX*GAMESIZEY):
		set_cell_V3(store_data[i])

func _ready() -> void:
	generate_world(GAMESIZEX,GAMESIZEY,CHANCE)
	Engine.time_scale = GAMESPEED
	

func _process(delta: float) -> void:
	#bad_simulation()
	simulation()
	pass



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dalej"):
		#bad_simulation()
		#simulation()
		pass
