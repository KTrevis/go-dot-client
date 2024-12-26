extends Node
class_name StateMachine

signal changed_state(stateName: String)

@onready var state: State = $default

func _ready() -> void:
	state.enter()

func _process(delta: float) -> void:
	state.process(delta)

func _physics_process(delta: float) -> void:
	state.physicsProcess(delta)

func setState(stateName: String, msg := {}) -> void:
	assert(has_node(stateName), "state not found %s" % stateName)
	state.exit()
	state = get_node(stateName)
	state.enter(msg)
	changed_state.emit(stateName)
