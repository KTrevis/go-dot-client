extends State

signal player_moved(newPos: Vector2i)

@onready var player: Player = stateMachine.get_node("..")
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
	player.gridPos = msg.cellDest
	player_moved.emit(player.gridPos)
	sendPosToServer()

func physicsProcess(delta: float) -> void:
	tilesPerSecond = 5
	player.position += direction * delta * (16 * tilesPerSecond)

func process(delta: float) -> void:
	if player.global_position.distance_to(destination) <= 1:
		player.global_position = destination
		stateMachine.setState("default", {"move": true})
