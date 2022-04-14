extends "res://xkyss/state_machine/state_machine.gd"


func _ready():
	states_map = {
		"idle": $Idle,
		"move": $Move,
	}
