extends "motion.gd"


const TAG = "[Idle]: "


func enter():
	print(TAG, 'enter')


func update(_delta):
	#print(TAG, 'update')
	var input_direction = get_input_direction()
	if input_direction:
		#print(TAG, 'change to state: move')
		emit_signal("finished", "move")


func exit():
	print(TAG, 'exit')
