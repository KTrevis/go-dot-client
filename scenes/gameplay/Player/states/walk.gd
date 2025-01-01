extends State

@onready var player: Player = stateMachine.get_node("..")
var destination := Vector2.ZERO

func enter(msg := {}) -> void:
	destination = msg.destination
	var direction := player.global_position.direction_to(destination)
	if player.willCollide(direction):
		stateMachine.setState("default")
		return
	player.velocity = direction * player.MOVEMENT_SPEED
	if direction == Vector2.ZERO:
		return stateMachine.setState("default", {"move": true})

func process(delta: float) -> void:
	if player.global_position.distance_to(destination) <= 1:
		player.velocity = Vector2.ZERO
		player.global_position = destination
		stateMachine.setState("default")
