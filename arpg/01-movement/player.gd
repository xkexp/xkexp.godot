extends KinematicBody2D

const TAG = '[Player]: '
# 最大速度
const MAX_SPEED = 500
# 加速度/摩擦力
const ACCELERATION = MAX_SPEED * 5

# 速度
var velocity = Vector2.ZERO


func _physics_process(delta):
	var input_direction = _get_input_direction()
	#velocity = input_direction * MAX_SPEED
	velocity = velocity.move_toward(input_direction * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)


func _get_input_direction() -> Vector2:
	var input_direction = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	return input_direction.normalized()
