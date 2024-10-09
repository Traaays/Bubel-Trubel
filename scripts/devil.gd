extends CharacterBody2D

class_name cnDevil

@onready var sprite = $AnimatedSprite2D
@onready var shadow = $shadow
@onready var devil = $"."
@onready var shoot = $ShootArea2D

var SPEED = 60.0
var casting = false
var lastXPosBeforeCast = 0

func _ready():
	shadow.modulate.a8 = 50
	sprite.animation = str(MySingleton.skin) + "stand"
	shadow.animation = str(MySingleton.skin) + "stand"
	_check_gh()

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
	
	if Input.is_action_just_pressed("Shoot") and casting == false:
		casting = true
		lastXPosBeforeCast = devil.position.x
	
	if casting == true:
		shoot.position.y -= delta*150
		shoot.position.x = lastXPosBeforeCast - devil.position.x

func _on_area_2d_body_entered(body):
	if body is cnBall:
		if MySingleton.lives > 1:
			MySingleton.lives -= 1
			if MySingleton.highscore < MySingleton.allscore + MySingleton.score:
				MySingleton.highscore = MySingleton.allscore + MySingleton.score
			get_tree().call_deferred("reload_current_scene")
		else:
			if MySingleton.highscore < MySingleton.allscore + MySingleton.score:
				MySingleton.highscore = MySingleton.allscore + MySingleton.score
			MySingleton.allscore = 0
			get_tree().call_deferred("change_scene_to_file", "res://scenes/startmenu.tscn")


func _on_shoot_area_2d_body_entered(body):
	if body.has_meta("cn"): #or platform
		if body.get_meta("cn") == "ceiling":
			casting = false
			shoot.position.y = 0
	elif body is cnBall:
		casting = false
		body._split(body)
		shoot.position.y = 0
		
func _check_gh():
	match MySingleton.skin:
		1:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/grey.tres")
		2:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/evil.tres")
		3:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/grey.tres")
		4:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/sprites/spritesheetgameboy.png")
		5:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/sprites/spritesheetvirtualboy.png")
