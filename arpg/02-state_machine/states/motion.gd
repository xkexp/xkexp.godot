extends "res://xkyss/state_machine/state.gd"

# warning-ignore-all:unused_class_variable
var speed = 0.0
var velocity = Vector2()


func get_input_direction() -> Vector2:
	var input_direction = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	return input_direction.normalized()
