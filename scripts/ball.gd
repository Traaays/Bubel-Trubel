extends CharacterBody2D

class_name cnBall
static var ballPL = preload("res://scenes/ball.tscn")
static var meshPL = preload("res://assets/balls/Mesh.tres")
static var popPL = preload("res://scenes/pop.tscn")

@onready var ball = $"."
@onready var cshape = $CollisionShape2D
@onready var mesh = $MeshInstance2D

@export var size = 32
@export var colour = "pink"
@export var rings: int
@export var direction = true

var SPEED = 30.0
var JUMP_VELOCITY = -225.0

var firstBall = true
var popsize
var popcolour = Color.GHOST_WHITE

func _ready():
	if firstBall == true:
		get_parent().amountAtBeginning += 1
	_check_colour()
	_check_mesh()
	cshape.shape.radius = size
	mesh.mesh.radius = size
	mesh.mesh.height = size * 2
	match int(cshape.shape.radius):
		32:
			JUMP_VELOCITY = JUMP_VELOCITY/1.1
			popsize = 0.4
		16:
			JUMP_VELOCITY = JUMP_VELOCITY/1.25
			popsize = 0.2
		8:
			JUMP_VELOCITY = JUMP_VELOCITY/1.5
			popsize = 0.1
		4:
			JUMP_VELOCITY = JUMP_VELOCITY/1.65
			popsize = 0.075
		2:
			JUMP_VELOCITY = JUMP_VELOCITY/1.8
			popsize = 0.05
	velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
	if direction:
		velocity.x = SPEED
	else:
		velocity.x = -SPEED
	move_and_slide()
	
func _check_colour():
	mesh.texture = load("res://assets/balls/" + str(colour) + ".tres")
	popcolour = Color(colour)

func _check_mesh():
	mesh.mesh = meshPL.duplicate()
	mesh.mesh.rings = rings
	
func _split():
	MySingleton.score += ball.cshape.shape.radius
	if mesh.mesh.radius > 2:
		for i in 2:
			var child = ballPL.instantiate()
			child.size = mesh.mesh.radius/2
			child.firstBall = false
			child.position = position
			child.colour = colour
			child.rings = rings
			if i == 1:
				child.direction = false
			$".".get_parent().call_deferred("add_child", child)
	var pop = popPL.instantiate()
	pop.position = position
	pop.scale = Vector2(popsize, popsize)
	pop.modulate = popcolour
	$".".get_parent().call_deferred("add_child", pop)
	call_deferred("queue_free")
