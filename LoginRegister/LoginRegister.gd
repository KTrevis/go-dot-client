extends Control

func submitForm() -> void:
	var data := {
		"username": %Username.text,
		"password": %Password.text,
	}
	WebSocket.send(WebSocket.MessageType.REGISTER_LOGIN, data)

func _ready() -> void:
	var button: Button = %Button
	button.pressed.connect(submitForm)
	WebSocket.message_received.connect(func(msg := {}) -> void:
		if "error" in msg:
			%Error.text = msg.error
	)
