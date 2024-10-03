extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var shadow = $shadow
@onready var devil = $"."

var SPEED = 60.0

func _ready():
	shadow.modulate.a8 = 50
	sprite.animation = str(MySingleton.skin) + "stand"
	shadow.animation = str(MySingleton.skin) + "stand"

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x != 0:
		sprite.animation = str(MySingleton.skin) + "run"
		shadow.animation = str(MySingleton.skin) + "run"
		if velocity.x < 0:
			sprite.flip_h = true
			shadow.flip_h = true
		else:
			sprite.flip_h = false
			shadow.flip_h = false
	else:
		sprite.animation = str(MySingleton.skin) + "stand"
		shadow.animation = str(MySingleton.skin) + "stand"

	move_and_slide()
	$"../UI/livesLabel".text = ("lives = " + str(MySingleton.lives))

func _on_area_2d_body_entered(body):
	if body:
		if MySingleton.lives > 1:
			MySingleton.lives -= 1
			get_tree().call_deferred("reload_current_scene")
		else:
			MySingleton.lives = MySingleton.maxLives
			get_tree().call_deferred("change_scene_to_file", "res://scenes/startmenu.tscn")
