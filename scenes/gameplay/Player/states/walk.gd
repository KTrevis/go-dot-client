extends State

signal player_moved(newPos: Vector2i)

@onready var player: Player = stateMachine.get_node("..")
@onready var tilemap: TileMapLayer = player.get_node("..")
var tilesPerSecond: int = 5
var destination := Vector2.ZERO
var direction := Vector2.ZERO

func sendPosToServer() -> void:
	WebSocket.send("UPDATE_PLAYER_POSITION", {
		"position": {
			"x": player.gridPos.x,
			"y": player.gridPos.y,
			}
		})

func enter(msg := {}) -> void:
	destination = msg.destination
	direction = player.global_position.direction_to(destination)
	if player.willCollide(direction):
		stateMachine.setState("default")
		return
	player.gridPos = tilemap.local_to_map(tilemap.to_local(msg.destination))
	player_moved.emit(player.gridPos)
	if is_multiplayer_authority():
		sendPosToServer()

func physicsProcess(delta: float) -> void:
	var distance := delta * (16 * tilesPerSecond)
	player.position += direction * distance

func process(delta: float) -> void:
	if player.global_position.distance_to(destination) <= 1:
		player.global_position = destination
		stateMachine.setState("default", {"move": true})
