extends State

@onready var player: Player = stateMachine.get_node("..")

func physicsProcess(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		stateMachine.setState("walk", {"direction": direction})
