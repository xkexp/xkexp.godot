extends "motion.gd"


const TAG = '[Move]: '
# 最大速度
const MAX_SPEED = 500


func enter():
	print(TAG, 'enter')
	speed = 0.0
	velocity = Vector2()


func update(delta: float):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	_move1()


func exit():
	print(TAG, 'exit')


# 移动(方式1)
func _move1():
	var direction = get_input_direction()
	velocity = direction * MAX_SPEED
	velocity = owner.move_and_slide(velocity)
