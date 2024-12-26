extends Control
class_name LoginScreen

func submitForm() -> void:
	var data := {
		"username": %Username.text,
		"password": %Password.text,
	}
	WebSocket.send("LOGIN", data)
	%Button.disabled = true

func _ready() -> void:
	var button: Button = %Button
	button.pressed.connect(submitForm)
	WebSocket.message_received.connect(func(msg := {}) -> void:
		%Button.disabled = false
		if "token" in msg:
			WebSocket.token = msg.token
			print(msg)
			queue_free()
			get_node("..").add_child(CSS.new())
			return
		if "error" in msg:
			%Error.text = msg.error
	)
