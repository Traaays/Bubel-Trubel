extends Node2D

var done = false

func _process(delta):
	if $Jack.position.x > -225 and done == false:
		$Jack.position.x -= delta * 25
	else:
		done = true
		$Jack.flip_h = true
		$Jack.position.x += delta * 35
