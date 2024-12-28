extends Button

var classList := {}

func onPress() -> void:
	WebSocket.send("GET_CLASSES")

func _ready() -> void:
	WebSocket.data_received.connect(func(data := {}):
		if "classes" not in data: return
		var ccs := CCS.loadScene()
		ccs.classesName = data.classes
		get_node("../..").add_child(ccs)
		get_node("..").queue_free()
		)
	pressed.connect(onPress)
