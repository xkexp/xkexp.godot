extends KinematicBody2D

const TAG = '[Player]: '
# 最大速度
const MAX_SPEED = 450
# 加速度/摩擦力
const ACCELERATION = 500

# 速度
var velocity = Vector2.ZERO


func _physics_process(delta):
	var input_direction = _get_input_direction()
	var acceleration = ACCELERATION * delta
	# 无操作
	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * MAX_SPEED, acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration)
	velocity = move_and_slide(velocity)


func _get_input_direction() -> Vector2:
	var input_direction = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	return input_direction.normalized()
