extends State

@onready var player: Player = stateMachine.get_node("..")
@onready var tilemap: TileMapLayer = player.get_node("..")

func getDirection() -> Vector2:
	var direction := Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP + Vector2.LEFT
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN + Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		direction += Vector2.LEFT + Vector2.DOWN
	if Input.is_action_pressed("ui_right"):
		direction += Vector2.RIGHT + Vector2.UP

	if direction.x < 0:
		direction.x = -1
	elif direction.x > 0:
		direction.x = 1

	if direction.y < 0:
		direction.y = -1
	elif direction.y > 0:
		direction.y = 1
	return direction

func move() -> void:
	var cellDest := tilemap.local_to_map(tilemap.to_local(player.global_position))
	var direction := getDirection()
	cellDest += Vector2i(direction)

	if direction:
		var destination := tilemap.map_to_local(cellDest)
		destination = tilemap.to_global(destination)
		stateMachine.setState("walk", {"destination": destination})

func enter(msg := {}) -> void:
	if "move" in msg:
		move()

func physicsProcess(delta: float) -> void:
	move()
