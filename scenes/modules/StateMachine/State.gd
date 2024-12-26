extends Node
class_name State

@onready var stateMachine: StateMachine = get_node("..")

func enter(msg := {}) -> void:
	pass

func process(delta: float) -> void:
	pass

func physicsProcess(delta: float) -> void:
	pass

func exit() -> void:
	pass
