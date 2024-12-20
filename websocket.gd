extends Node

enum MessageType {
	NONE,
	REGISTER_LOGIN,
}

@export var ip := "127.0.0.1:8080/websocket"

signal message_received(message: Dictionary)

var _webSocket := WebSocketPeer.new()

func send(type: MessageType, msg := {}) -> void:
	_webSocket.send_text(JSON.stringify(type))
	_webSocket.send_text(JSON.stringify(msg))

func _readPackets() -> void:
	var message := _webSocket.get_packet().get_string_from_utf8()
	if message:
		message_received.emit(JSON.parse_string(message))

func _ready() -> void:
	_webSocket.connect_to_url("ws://%s" % ip)

func _process(delta: float) -> void:
	_webSocket.poll()
	var state := _webSocket.get_ready_state()
	match state:
		WebSocketPeer.STATE_OPEN:
			_readPackets()
		WebSocketPeer.STATE_CLOSED:
			_webSocket.connect_to_url("ws://%s" % ip)
