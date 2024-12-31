extends Control
class_name CCS

var classesName := []

func onClassPick(button: Button):
	$Label.text = button.text

static func loadScene(data := {}) -> CCS:
	return load("res://scenes/UI/CCS/CCS.tscn").instantiate() as CCS

func _ready() -> void:
	$LineEdit.grab_focus()
	WebSocket.data_received.connect(onDataReceived)
	$ClassName.text = classesName[0]
	for name in classesName:
		var button := Button.new()
		button.text = name
		$FlowContainer.add_child(button)
		button.pressed.connect(onClassPick.bind(button))

func onDataReceived(type: String, data := {}) -> void:
	if type != "CREATE_CHARACTER":
		return
	if "success" in data:
		queue_free()
		get_node("/root/main").add_child(CSS.loadScene())
		return
	$Error.text = data.error

func _on_create_character_pressed() -> void:
	WebSocket.send("CREATE_CHARACTER", {
		"class": $ClassName.text,
		"name": $LineEdit.text
	})
