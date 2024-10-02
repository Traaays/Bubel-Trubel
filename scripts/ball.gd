extends CharacterBody2D

@onready var test_level = $"."
@onready var cshape = $CollisionShape2D
@onready var mesh = $MeshInstance2D

@export var size = 32
@export var colour = "pink"
@export var typamesh = "octagon"

@export var direction = true

var SPEED = 30.0
var JUMP_VELOCITY = -225.0

var firstBall = true


func _ready():
	if firstBall == true:
		$".".get_parent().amountAtBeginning += 1
	_check_colour(colour)
	_check_mesh(typamesh)
	cshape.shape.radius = size
	mesh.mesh.radius = size
	mesh.mesh.height = size * 2
	match int(cshape.shape.radius):
		32:
			JUMP_VELOCITY = JUMP_VELOCITY/1.1
		16:
			JUMP_VELOCITY = JUMP_VELOCITY/1.25
		8:
			JUMP_VELOCITY = JUMP_VELOCITY/1.5
		4:
			JUMP_VELOCITY = JUMP_VELOCITY/1.65
		2:
			JUMP_VELOCITY = JUMP_VELOCITY/1.8
	if int(cshape.shape.radius) <= 1.9:
		queue_free()
	velocity.y = JUMP_VELOCITY
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

	if direction:
		velocity.x = SPEED
	else:
		velocity.x = -SPEED

	move_and_slide()
	
func _check_colour(b):
	match b:
		"pink":
			mesh.texture = load("res://assets/balls/pinkballtexture.tres")
		"red":
			mesh.texture = load("res://assets/balls/redballtexture.tres")

func _check_mesh(b):
	match b:
		"octagon":
			mesh.mesh = load("res://assets/balls/Octagon.tres").duplicate()
		"decagon":
			mesh.mesh = load("res://assets/balls/Decagon.tres").duplicate()
	
func _split(level):
	var child1 = load("res://scenes/ball.tscn").instantiate()
	child1.size = mesh.mesh.radius/2
	child1.firstBall = false
	child1.position = position
	child1.colour = colour
	child1.typamesh = typamesh
	$".".get_parent().call_deferred("add_child", child1)
	
	var child2 = load("res://scenes/ball.tscn").instantiate()
	child2.size = mesh.mesh.radius/2
	child2.firstBall = false
	child2.position = position
	child2.colour = colour
	child2.typamesh = typamesh
	child2.direction = false
	$".".get_parent().call_deferred("add_child", child2)
	queue_free()
