extends Node2D

var amountOfChild
var amountAtBeginning = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	MySingleton.score = 0
	MySingleton.currentLevel = $".".get_parent().get_meta("level")
	amountOfChild = $".".get_child_count()
	amountAtBeginning = amountOfChild - amountAtBeginning
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print (MySingleton.score)
	print (MySingleton.allscore)
	
	amountOfChild = $".".get_child_count()
	$UI/livesLabel.text = ("lives = " + str(MySingleton.lives))
	$UI/scoreLabel.text = ("score = " + str(MySingleton.score + MySingleton.allscore))
	if amountOfChild == amountAtBeginning:
		_end_of_level()
	
func _on_walls_body_entered(body):
	if body is cnBall:
		if body.direction == false:
			body.direction = true
		else:
			body.direction = false
		
func _on_ceiling_area_body_entered(body):
	if body is cnBall:
		body._split(body)

func _end_of_level():
	MySingleton.allscore += MySingleton.score
	get_tree().change_scene_to_file("res://scenes/level" + str(MySingleton.currentLevel + 1) + ".tscn")
