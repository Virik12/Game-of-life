extends TileMapLayer

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
	print(how_many_black)


func _ready() -> void:
	var surroundings_cords = get_surroundings(Vector2i(0,5))
	var how_many_black = check_surroundings_atlas(surroundings_cords)
	pass 


func _process(delta: float) -> void:
	pass
