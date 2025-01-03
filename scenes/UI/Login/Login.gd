extends Control
class_name LoginScreen

var error := ""

static func loadScene() -> LoginScreen:
	return load("res://scenes/UI/Login/Login.tscn").instantiate()

func submitForm() -> void:
	var data := {
		"username": %Username.text,
		"password": %Password.text,
	}
	WebSocket.send("LOGIN", data)
	%Button.disabled = true

func onMessage(type: String, msg := {}) -> void :
	if type != "LOGIN":
		return
	%Button.disabled = false
	if "authenticated" in msg:
		get_node("..").add_child(CSS.loadScene())
		queue_free()
		return

	if "error" in msg:
		%Error.text = msg.error

func onConnection(button: Button):
	button.disabled = false

func onDisconnection(error: String, button: Button):
	button.disabled = false

func _ready() -> void:
	var button: Button = %Button
	%Error.text = error

	%Username.grab_focus()
	button.disabled = true
	button.pressed.connect(submitForm)
	WebSocket.data_received.connect(onMessage)
	WebSocket.connected.connect(onConnection.bind(button))
	WebSocket.disconnected.connect(onDisconnection.bind(button))
