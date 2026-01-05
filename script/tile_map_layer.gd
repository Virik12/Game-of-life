extends TileMapLayer

const GamesizeX = 128
const GamesizeY = 96
const Chance = 10

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

func set_cell_black(Vector):
	set_cell(Vector,1,Vector2i(0,0))

func set_cell_white(Vector):
	set_cell(Vector,1,Vector2i(0,1))

func generate_world(SizeX,SizeY,Chance):
	for i in range(1,SizeX + 1):
		for j in range(1,SizeY + 1):
			var rand = randi() % 101
			#print(rand)
			if rand<Chance:
				set_cell_black(Vector2i(i-SizeX/2,j-SizeY/2))
			else:
				set_cell_white(Vector2i(i-SizeX/2,j-SizeY/2))


func _ready() -> void:
	generate_world(GamesizeX,GamesizeY,Chance)
	Engine.time_scale = 0.1

func _process(delta: float) -> void:
	for i in range(1,GamesizeX + 1):
		for j in range(1,GamesizeY + 1):
			var surroundings_cords=get_surroundings(Vector2i(i-GamesizeX/2,j-GamesizeY/2))
			var how_many_black=check_surroundings_atlas(surroundings_cords)
			
			if how_many_black == 3:
				set_cell_black(Vector2i(i-GamesizeX/2,j-GamesizeY/2))
			elif how_many_black < 2 or how_many_black > 3:
				set_cell_white(Vector2i(i-GamesizeX/2,j-GamesizeY/2))
