extends CharacterBody2D

class_name cnBall

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
		$".".get_parent().amountAtBeginning += 1
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
	
func _check_colour():
	mesh.texture = load("res://assets/balls/" + str(colour) + ".tres")
	popcolour = Color(colour)

func _check_mesh():
	mesh.mesh = load("res://assets/balls/Mesh.tres").duplicate()
	mesh.mesh.rings = rings
	
	
func _split():
	if mesh.mesh.radius > 2:
		var child1 = load("res://scenes/ball.tscn").instantiate()
		child1.size = mesh.mesh.radius/2
		child1.firstBall = false
		child1.position = position
		child1.colour = colour
		child1.rings = rings
		$".".get_parent().call_deferred("add_child", child1)
		
		var child2 = load("res://scenes/ball.tscn").instantiate()
		child2.size = mesh.mesh.radius/2
		child2.firstBall = false
		child2.position = position
		child2.colour = colour
		child2.rings = rings
		child2.direction = false
		$".".get_parent().call_deferred("add_child", child2)
	
	MySingleton.score += ball.cshape.shape.radius
	var pop = load("res://scenes/pop.tscn").instantiate()
	pop.position = position
	pop.scale = Vector2(popsize, popsize)
	pop.modulate = popcolour
	$".".get_parent().call_deferred("add_child", pop)
		
	queue_free()
