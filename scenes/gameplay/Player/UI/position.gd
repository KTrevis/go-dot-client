extends Label

func _on_walk_player_moved(newPos: Vector2i) -> void:
	text = str(newPos)
