extends Node2D

const TAG='[BulletSpawner]: '

var bullet = preload("Bullet.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("fire"):
		print(TAG, 'fire')
		fire()


func fire():
	if not $CooldownTimer.is_stopped():
		return

	$CooldownTimer.start()
	var new_bullet = bullet.instance()
	add_child(new_bullet)
	new_bullet.position = global_position
	#new_bullet.direction = owner.look_direction
