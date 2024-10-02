extends Node2D

@onready var devil = $Devil
@onready var shoot = $ShootArea2D

var casting = false
var lastXPosBeforeCast = 0

var amountOfChild
var amountAtBeginning = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	MySingleton.currentLevel = $".".get_parent().get_meta("level")
	amountOfChild = $".".get_child_count()
	amountAtBeginning = amountOfChild - amountAtBeginning
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Shoot") and casting == false:
		casting = true
		lastXPosBeforeCast = devil.position.x
	
	if casting == true:
		shoot.position.y -= delta*150
		shoot.position.x = lastXPosBeforeCast
	
	amountOfChild = $".".get_child_count()
	_check_if_done()
		
	
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

func _check_if_done():
	if amountOfChild == amountAtBeginning:
		_end_of_level()

func _end_of_level():
	match MySingleton.currentLevel + 1:
		2:
			get_tree().change_scene_to_file("res://scenes/level2.tscn")
		3:
			get_tree().change_scene_to_file("res://scenes/level3.tscn")
