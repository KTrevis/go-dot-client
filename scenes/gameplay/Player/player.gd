extends CharacterBody2D
class_name Player

var MOVEMENT_SPEED := 200
@onready var stateMachine: StateMachine = $StateMachine

func _physics_process(delta: float) -> void:
	move_and_slide()
