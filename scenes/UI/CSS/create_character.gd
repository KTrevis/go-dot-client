extends Button

var classList := {}

func onPress() -> void:
	WebSocket.send("GET_CLASS_LIST")

func onMsg(type: String, data := {}) -> void:
	if type != "GET_CLASS_LIST":
		return
	var ccs := CCS.loadScene()
	ccs.classesName = data.classes
	get_node("/root/main").add_child(ccs)
	get_node("../..").queue_free()

func _ready() -> void:
	WebSocket.data_received.connect(onMsg)
	pressed.connect(onPress)
