extends CharacterBody2D
class_name Player

@onready var raycast: RayCast2D = $RayCast2D
var MOVEMENT_SPEED := 100

@onready var stateMachine: StateMachine = $StateMachine

static func loadScene() -> Player:
	return preload("res://scenes/gameplay/Player/player.tscn").instantiate()

func _physics_process(delta: float) -> void:
	move_and_slide()
