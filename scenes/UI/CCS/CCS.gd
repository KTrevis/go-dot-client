extends Control
class_name CCS

var classesName := []

func onClassPick(button: Button):
	$Label.text = button.text

static func loadScene(data := {}) -> CCS:
	return load("res://scenes/UI/CCS/CCS.tscn").instantiate() as CCS

func _ready() -> void:
	$Label.text = classesName[0]
	for str in classesName:
		var button := Button.new()
		button.text = str
		$FlowContainer.add_child(button)
		button.pressed.connect(onClassPick.bind(button))

func _on_create_character_pressed() -> void:
	WebSocket.send("CREATE_CHARACTER", {
		"class": $Label.text,
		"name": $LineEdit.text
	})
