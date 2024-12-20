extends BoxContainer

func submitForm() -> void:
	var socket: WebSocket = $WebSocket
	var data := {
		"username": $Username.text,
		"password": $Password.text,
	}
	socket.send(WebSocket.MessageType.REGISTER_LOGIN, data)

func _ready() -> void:
	var button: Button = $Button
	button.pressed.connect(submitForm)

func _on_web_socket_message_received(message: Dictionary) -> void:
	print(message)
