extends CharacterBody2D

class_name cnDevil

@onready var sprite = $AnimatedSprite2D
@onready var shadow = $shadow
@onready var devil = $"."
@onready var shoot = $ShootArea2D

static var skin = 1

var SPEED = 60.0
var casting = false
var lastXPosBeforeCast = 0

func _ready():
	shadow.modulate.a8 = 50
	sprite.animation = str(skin) + "stand"
	shadow.animation = str(skin) + "stand"
	_check_gh()

func _physics_process(delta):
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x != 0:
		sprite.animation = str(skin) + "run"
		shadow.animation = str(skin) + "run"
		if velocity.x < 0:
			sprite.flip_h = true
			shadow.flip_h = true
		else:
			sprite.flip_h = false
			shadow.flip_h = false
	else:
		sprite.animation = str(skin) + "stand"
		shadow.animation = str(skin) + "stand"

	move_and_slide()
	
	if Input.is_action_just_pressed("Shoot") and casting == false:
		casting = true
		lastXPosBeforeCast = devil.position.x
	
	if casting == true:
		shoot.position.y -= delta*150
		shoot.position.x = lastXPosBeforeCast - devil.position.x

func _on_area_2d_body_entered(body):
	if body is cnBall:
		MySingleton.die()


func _on_shoot_area_2d_body_entered(body):
	if body.has_meta("cn"): #or platform
		if body.get_meta("cn") == "ceiling":
			casting = false
			shoot.position.y = 0
	elif body is cnBall:
		casting = false
		body._split()
		shoot.position.y = 0
		
func _check_gh():
	match skin:
		1:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/grey.tres")
		2:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/evil.tres")
		3:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/sprites/devils/spritesheetgameboy.png")
		4:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/sprites/devils/spritesheetvirtualboy.png")
		5:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/white.tres")
		6:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/pump.tres")
		7:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/joki.jpg")
