extends Button

func onPress() -> void:
	WebSocket.send("GET_CLASSES")

func _ready() -> void:
	pressed.connect(onPress)
