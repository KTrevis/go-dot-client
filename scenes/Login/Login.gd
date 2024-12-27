extends Control
class_name LoginScreen

func submitForm() -> void:
	var data := {
		"username": %Username.text,
		"password": %Password.text,
	}
	WebSocket.send("LOGIN", data)
	%Button.disabled = true

func onMessage(msg := {}) -> void :
	%Button.disabled = false
	if "authenticated" in msg:
		get_node("..").add_child(CSS.loadScene())
		queue_free()
		return

	if "error" in msg:
		%Error.text = msg.error

func _ready() -> void:
	var button: Button = %Button

	%Username.grab_focus()
	button.disabled = true
	button.pressed.connect(submitForm)
	WebSocket.message_received.connect(onMessage)
	WebSocket.connected.connect(func(): button.disabled = false)
	WebSocket.disconnected.connect(func(): button.disabled = true)
