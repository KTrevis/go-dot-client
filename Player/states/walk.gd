extends State

@onready var player: Player = stateMachine.get_node("..")
var direction := Vector2.ZERO

func enter(msg := {}) -> void:
	direction = msg.direction
	player.velocity = direction * player.MOVEMENT_SPEED
	if direction == Vector2.ZERO:
		return stateMachine.setState("default")

func process(delta: float) -> void:
	var newDirection := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if newDirection != direction:
		stateMachine.setState("walk", {"direction": newDirection})
