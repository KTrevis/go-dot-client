extends State

@onready var player: Player = stateMachine.get_node("..")
@onready var tilemap: TileMapLayer = player.get_node("..")

func getDirection() -> Vector2i:
	if Input.is_action_pressed("ui_up"):
		return Vector2i.UP
	if Input.is_action_pressed("ui_down"):
		return Vector2i.DOWN
	if Input.is_action_pressed("ui_left"):
		return Vector2i.LEFT
	if Input.is_action_pressed("ui_right"):
		return Vector2i.RIGHT
	return Vector2i.ZERO

func move() -> void:
	var cellDest := tilemap.local_to_map(tilemap.to_local(player.global_position))
	var direction := getDirection()
	cellDest += direction

	if direction:
		var destination := tilemap.map_to_local(cellDest)
		destination = tilemap.to_global(destination)
		stateMachine.setState("walk", {
			"destination": destination,
			"cellDest": cellDest
			})

func enter(msg := {}) -> void:
	if "move" in msg:
		move()

func physicsProcess(delta: float) -> void:
	move()
