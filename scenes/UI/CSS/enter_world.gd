extends Button

@onready var css: CSS = get_node("../..")

func onPress() -> void:
	WebSocket.send("GET_MAP", {"map": "test"})

func onMsg(msgType: String, data: Dictionary):
	if msgType != "GET_MAP":
		return
	var drawer := MapDrawer.loadScene()
	drawer.drawMap(data.map)
	get_node("/root/main").add_child(drawer)
	get_node("../..").queue_free()
	drawer.add_child(Player.loadScene())

func _ready() -> void:
	WebSocket.data_received.connect(onMsg)
	pressed.connect(onPress)
