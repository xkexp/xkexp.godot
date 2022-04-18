extends Node
# 状态机基类


signal state_changed(current_state)


const TAG = '[StateMachine]: '
const State = preload("./state.gd")
const KsInput = preload("res://xkyss/input/input.gd")


var current_state: State
var states_map = {}
var _active = false setget set_active


func _ready():
	var input = KsInput.new()
	input.register_controls()
	add_child(input)
	
	assert(get_child_count() > 0, "一个State都没有")
	var children = get_children()
	for child in children:
		child.connect('finished', self, '_change_state')
	set_active(true)
	current_state = children[0]
	current_state.enter()


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


func _change_state(state_name: String):
	#print(TAG, '_change_state to ', state_name, ', _active: ', _active)
	if not _active:
		return
	current_state.exit()
	current_state = states_map[state_name]

	emit_signal("state_changed", current_state)
	current_state.enter()
