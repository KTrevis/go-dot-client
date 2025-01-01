extends State

@onready var player: Player = stateMachine.get_node("..")
var tilesPerSecond := 5
var destination := Vector2.ZERO
var direction := Vector2.ZERO

func enter(msg := {}) -> void:
	destination = msg.destination
	direction = player.global_position.direction_to(destination)
	if player.willCollide(direction):
		stateMachine.setState("default")
		return
	var cellDest: Vector2 = msg.cellDest
	WebSocket.send("UPDATE_PLAYER_POSITION", {
		"position": {
			"x": cellDest.x,
			"y": cellDest.y,
			}
		})
	if direction == Vector2.ZERO:
		return stateMachine.setState("default", {"move": true})

func physicsProcess(delta: float) -> void:
	player.position += direction * delta * (16 * tilesPerSecond)

func process(delta: float) -> void:
	if player.global_position.distance_to(destination) <= 1:
		player.global_position = destination
		stateMachine.setState("default", {"move": true})
