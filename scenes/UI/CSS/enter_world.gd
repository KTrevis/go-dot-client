extends Button

@onready var css: CSS = get_node("../..")

func onPress() -> void:
	WebSocket.send("ENTER_WORLD", {"character": css.characterPicked})

func onMsg(msgType: String, data: Dictionary):
	if msgType != "ENTER_WORLD":
		return
	var drawer := MapDrawer.loadScene()
	drawer.drawMap(data.map)
	get_node("/root/main").add_child(drawer)
	get_node("../..").queue_free()
	var player := Player.loadScene()
	var position := Vector2(
		data.character.Position.X,
		data.character.Position.Y,
	)
	position = drawer.map_to_local(position)
	player.position = position
	drawer.add_child(player)

func _ready() -> void:
	WebSocket.data_received.connect(onMsg)
	pressed.connect(onPress)
