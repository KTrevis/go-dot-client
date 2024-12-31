extends Button

var css := CSS.loadScene()

func onPress() -> void:
	get_node("..").queue_free()
	get_node("/root/main").add_child(css)

func _ready() -> void:
	pressed.connect(onPress)
