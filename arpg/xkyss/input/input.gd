extends Node


const controls = {
	'move_left': [KEY_LEFT, KEY_A],
	'move_right': [KEY_RIGHT, KEY_D],
	'move_up': [KEY_UP, KEY_W],
	'move_down': [KEY_DOWN, KEY_S],
}

func _ready():
	register_controls()

func register_controls():
	for action in controls:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for key in controls[action]:
			var ev = InputEventKey.new()
			ev.scancode = key
			InputMap.action_add_event(action, ev)
