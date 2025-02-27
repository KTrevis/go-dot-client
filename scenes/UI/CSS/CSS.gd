extends Control
class_name CSS

var characterPicked := ""

static func loadScene() -> CSS:
	return load("res://scenes/UI/CSS/CSS.tscn").instantiate()

func onCharacterClick(characterName: String):
	%CharacterName.text = characterName
	characterPicked = characterName

func updateCharacterList(type := "", data := {}) -> void:
	if type != "GET_CHARACTER_LIST":
		return
	var characterList: Array = data.characterList

	characterPicked = ""
	%EnterWorld.disabled = true
	if characterList.size() != 0:
		%EnterWorld.disabled = false
		characterPicked = characterList[0].Name
	%CharacterName.text = characterPicked
	for node: Node in %CharacterContainer.get_children():
		node.queue_free()
	for character in characterList:
		var button := Button.new()
		button.text = "%s\n%s Level %d" % [character.Name, character.Class, character.Level]
		%CharacterContainer.add_child(button)
		button.pressed.connect(onCharacterClick.bind(character.Name))

func _ready() -> void:
	%EnterWorld.grab_focus()
	WebSocket.data_received.connect(updateCharacterList)
	WebSocket.send("GET_CHARACTER_LIST")
