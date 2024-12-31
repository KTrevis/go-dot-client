extends Button

@onready var css: CSS = get_node("../..")

func onChoiceMade(choice: String) -> void:
	if choice == "No":
		return
	WebSocket.send("DELETE_CHARACTER", {"name": css.characterPicked})
	WebSocket.send("GET_CHARACTER_LIST")

func onPress() -> void:
	var choiceBox := ChoiceBox.loadScene()

	choiceBox.choices = ["Yes", "No"]
	choiceBox.prompt = "Are you sure you want to delete %s?" % [css.characterPicked]
	choiceBox.choice_made.connect(onChoiceMade)
	get_node("/root").add_child(choiceBox)

func _ready() -> void:
	pressed.connect(onPress)
