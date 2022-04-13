extends KinematicBody2D

const TAG = '[Player]: '
# 最大速度
const MAX_SPEED = 500
# 加速度/摩擦力
const ACCELERATION = MAX_SPEED * 5

# 速度
var velocity = Vector2.ZERO


func _physics_process(delta):
	#_move1()
	_move2(delta)


# 移动(方式1)
func _move1():
	var direction = _get_input_direction()
	velocity = direction * MAX_SPEED
	velocity = move_and_slide(velocity)


# 移动(方式2, 带摩擦力)
func _move2(delta: float):
	var direction = _get_input_direction()
	if velocity != Vector2.ZERO:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta * 2)
	velocity = move_and_slide(velocity)


func _get_input_direction() -> Vector2:
	var input_direction = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	return input_direction.normalized()
