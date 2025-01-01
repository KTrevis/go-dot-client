extends Node2D
class_name Player

@onready var raycast: RayCast2D = $RayCast2D
@onready var stateMachine: StateMachine = $StateMachine

static func loadScene() -> Player:
	return preload("res://scenes/gameplay/Player/player.tscn").instantiate()

func willCollide(direction := Vector2.ZERO) -> bool:
	if direction:
		raycast.target_position = direction * 16
	raycast.force_raycast_update()
	return raycast.get_collider() != null
