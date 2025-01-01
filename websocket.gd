extends Node

var ip := "127.0.0.1:8080/websocket"

signal data_received(type: String, data: Dictionary)
signal connected
signal disconnected(error: String)

var _webSocket := WebSocketPeer.new()
var _isConnected := false

func send(type: String, msg := {}) -> void:
	var data := type + "\r\n"
	data += JSON.stringify(msg)
	_webSocket.send_text(data)

func _readPackets() -> void:
	var message := _webSocket.get_packet().get_string_from_utf8()
	if message:
		var split := message.split("\r\n")
		assert(split.size() == 2)
		var dict: Dictionary = JSON.parse_string(split[1])
		data_received.emit(split[0], dict)

func returnToLogin(error: String):
	var loginScreen := LoginScreen.loadScene()
	for child in get_node("/root/main").get_children():
		if child.name != name:
			child.queue_free()
	loginScreen.error = error
	get_node("/root/main").add_child(loginScreen)

func _ready() -> void:
	var host = JavaScriptBridge.eval("window.location.host")
	if host != null:
		ip = host + "/websocket"

	_webSocket.connect_to_url("ws://%s" % ip)
	disconnected.connect(returnToLogin)

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
				var error := _webSocket.get_close_reason()
				if _webSocket.get_close_code() == -1:
					error = "server down"
				disconnected.emit(error)
			_isConnected = false
			_webSocket.connect_to_url("ws://%s" % ip)
