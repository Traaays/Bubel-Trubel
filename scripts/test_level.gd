extends Node2D

@onready var devil = $Devil
@onready var shoot = $ShootArea2D
var casting = false
var lastXPosBeforeCast = 0

var amountOfChild
var amountAtBeginning = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if MySingleton.twop == true:
		_do_2p()
	MySingleton.currentLevel = $".".get_parent().get_meta("level")
	amountOfChild = $".".get_child_count()
	amountAtBeginning = amountOfChild - amountAtBeginning
	_check_gh()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Shoot") and casting == false:
		casting = true
		lastXPosBeforeCast = devil.position.x
	
	if casting == true:
		shoot.position.y -= delta*150
		shoot.position.x = lastXPosBeforeCast

	amountOfChild = $".".get_child_count()
	if amountOfChild == amountAtBeginning:
		_end_of_level()
		
	
func _on_walls_body_entered(body):
	if body != $Ground and body != $Ceiling and body != $Devil and body != $WallsCollision:
		if body.direction == false:
			body.direction = true
		else:
			body.direction = false


func _on_shoot_area_2d_body_entered(body):
	if body == $Ceiling: #or platform
		casting = false
		shoot.position.y = 208
	elif body != $Devil and body != $Ground and body != $Walls and body != $WallsCollision:
		body._split(body)
		casting = false
		shoot.position.y = 208
		
func _on_ceiling_area_body_entered(body):
	if body != $Ground and body != $Ceiling and body != $Devil and body != $WallsCollision:
		body._split(body)

func _end_of_level():
	match MySingleton.currentLevel + 1:
		2:
			get_tree().change_scene_to_file("res://scenes/level2.tscn")
		3:
			get_tree().change_scene_to_file("res://scenes/level3.tscn")

func _check_gh():
	match MySingleton.skin:
		1:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/grey.tres")
		2:
			$ShootArea2D/MeshInstance2D.texture = load("res://assets/hooks/evil.tres")
			
func _do_2p():
	var child1 = load("res://scenes/devil.tscn").instantiate()
	child1.name = "Devil2"
	$".".add_child(child1)

	var child2 = load("res://scenes/devil.tscn").instantiate()
	child2.name = "ShootArea2D2"
	$".".add_child(child2)
	
	var devil2 = $Devil2
	var shoot2 = $ShootArea2D2
	var casting2 = false
	var lastXPosBeforeCast2 = 0
