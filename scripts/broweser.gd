extends CharacterBody2D

class_name broweser

const SPEED = 30.0
var JUMP_VELOCITY = -40.0
var hammers = 0

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = JUMP_VELOCITY
		
	if JUMP_VELOCITY == -40.0:
		if $leftright.time_left >= $leftright.wait_time/2:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED
	else:
		velocity.x = 0

	move_and_slide()


func _on_leftright_timeout():
	$leftright.wait_time = randf_range(1,2)
	$leftright.start()
	var jumpOrNo = randi_range(1,6)
	if jumpOrNo == 3 or jumpOrNo == 4:
		JUMP_VELOCITY = -180.0
	elif jumpOrNo == 2:
		$hammertimer.start()
	else:
		JUMP_VELOCITY = -40.0

func _on_hammertimer_timeout():
	if hammers <= 4:
		hammertime()
		$hammertimer.start()
		hammers += 1
	else:
		hammers = 0

func hammertime():
	var hammer = (cnBall.ballPL).instantiate()
	hammer.size = 8
	hammer.colour = "orange_red"
	hammer.rings = 4
	hammer.direction = false
	hammer.position = $MeshInstance2D2.global_position
	get_parent().add_child(hammer)
