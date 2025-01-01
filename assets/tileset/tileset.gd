extends TileMapLayer
class_name MapDrawer

static func loadScene() -> MapDrawer:
	return load("res://assets/tileset/tileset.tscn").instantiate()

func drawMap(map: Array) -> void:
	var x := 0
	var y := 0

	for line: Array in map:
		for cell: Dictionary in line:
			var vect := Vector2i(cell.X, cell.Y)
			set_cell(Vector2i(x, y), 0, vect)
			x += 1
		x = 0
		y += 1
