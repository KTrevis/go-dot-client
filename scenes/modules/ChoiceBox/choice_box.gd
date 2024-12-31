extends PanelContainer
class_name ChoiceBox

signal choice_made(choice: String)

var prompt := ""
@export var choices: Array[String] = []

static func loadScene() -> ChoiceBox:
	return load("res://scenes/modules/ChoiceBox/ChoiceBox.tscn").instantiate()

func onChoiceMade(choice: String) -> void:
	choice_made.emit(choice)
	queue_free()

func _ready() -> void:
	%Prompt.text = prompt
	for choice in choices:
		var button := Button.new()
		button.text = choice
		$ButtonContainer.add_child(button)
		button.pressed.connect(onChoiceMade.bind(choice))
		button.grab_focus()
