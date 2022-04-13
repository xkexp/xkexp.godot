extends Node
# 状态机基类


signal state_changed(current_state)


const State = preload("./state.gd")


var current_state: State
var _active = false setget set_active


func _ready():
	for child in get_children():
		child.connect('finished', self, '_change_state')


func _unhandled_input(event):
	current_state.handle_input(event)


func _physics_process(delta):
	current_state.update(delta);


func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	# clean up
	if not _active:
		current_state = null


func _change_state():
	if not _active:
		return
	current_state.exit()

	emit_signal("state_changed", current_state)
