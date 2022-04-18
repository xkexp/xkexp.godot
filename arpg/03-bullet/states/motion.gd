extends "res://xkyss/state_machine/state.gd"

# warning-ignore-all:unused_class_variable
var speed = 0.0
var velocity = Vector2()


func get_input_direction() -> Vector2:
	var input_direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	return input_direction.normalized()
