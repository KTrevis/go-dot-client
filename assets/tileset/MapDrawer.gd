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

func findPlayerWithName(characterName: String) -> Player:
	var players := get_tree().get_nodes_in_group("player")
	for player: Player in players:
		if player.name == characterName:
			return player
	return null

func movePlayer(data: Dictionary) -> void:
	var playerLoaded := false
	var character: Dictionary = data.character
	var player := findPlayerWithName(character.Name)

	if player != null:
		var destination := map_to_local(Vector2i(
			character.Position.X, character.Position.Y
		))
		return player.stateMachine.setState("walk", {"destination": destination})
	var newPlayer := Player.loadScene()
	var position := Vector2i(character.Position.X, character.Position.Y)
	newPlayer.position = map_to_local(position)
	newPlayer.name = character.Name
	newPlayer.set_multiplayer_authority(0)
	add_child(newPlayer)

func onMsg(type: String, data: Dictionary) -> void:
	if type == "MOVE_PLAYER":
		return movePlayer(data)
	if type != "SEND_MAP":
		return
	drawMap(data.map)

func _ready() -> void:
	WebSocket.data_received.connect(onMsg)
	WebSocket.send("GET_CHUNKS")
