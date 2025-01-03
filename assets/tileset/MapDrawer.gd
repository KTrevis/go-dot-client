extends TileMapLayer
class_name MapDrawer

static func loadScene() -> MapDrawer:
	return load("res://assets/tileset/MapDrawer.tscn").instantiate()

func drawMap(map: Dictionary) -> void:
	const CHUNK_SIZE := 50
	var tiles: Array = map.Tiles
	var x: int = CHUNK_SIZE * map.Position.X
	var y: int = CHUNK_SIZE * map.Position.Y

	for line: Array in tiles:
		for cell: Dictionary in line:
			var vect := Vector2i(cell.X, cell.Y)
			set_cell(Vector2i(x, y), 0, vect)
			x += 1
		x = 0
		y += 1

func onMsg(type: String, data: Dictionary):
	if type != "SEND_MAP":
		return
	drawMap(data.map)

func _ready() -> void:
	WebSocket.data_received.connect(onMsg)
	WebSocket.send("IN_GAME")
