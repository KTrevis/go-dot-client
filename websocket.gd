extends Node

@export var ip := "127.0.0.1:8080/websocket"

signal message_received(message: Dictionary)
signal connected

var _webSocket := WebSocketPeer.new()
var _isConnected := false
var token := ""

func send(type: String, msg := {}) -> void:
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
			if !_isConnected:
				_isConnected = true
				print("Websocket connected")
				connected.emit()
			_readPackets()
		WebSocketPeer.STATE_CLOSED:
			if _isConnected:
				print("Websocket disconnected")
			_isConnected = false
			_webSocket.connect_to_url("ws://%s" % ip)
