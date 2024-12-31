extends Control
class_name CSS

static func loadScene() -> CSS:
	return load("res://scenes/UI/CSS/CSS.tscn").instantiate()

func updateCharacterList(data := {}) -> void:
	if "characterList" not in data:
		return
	for character in data.characterList:
		var button := Button.new()
		button.text = "%s\n%s Level %d" % [character.Name, character.Class, character.Level]
		%CharacterContainer.add_child(button)
		%CharacterContainer.add_child(button.duplicate())

func _ready() -> void:
	WebSocket.data_received.connect(updateCharacterList)
	WebSocket.send("GET_CHARACTER_LIST")
