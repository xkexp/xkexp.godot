extends Node
# 状态基类


# warning-ignore:unused_signal
signal finished(next_state_name)


func enter():
	pass


func exit():
	pass


func update(delta: float):
	pass


func handle_input(event: InputEvent):
	pass
