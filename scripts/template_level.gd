extends Node2D

var amountOfChild
var amountAtBeginning = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	MySingleton.score = 0
	amountOfChild = $".".get_child_count()
	amountAtBeginning = amountOfChild - amountAtBeginning
	if MySingleton.currentLevel < 8:
		$UI/livesLabel.text = ("lives = " + str(MySingleton.lives))
	else:
		$UI/livesLabel.text = ("lives = ∞")
	$UI/scoreLabel.text = ("score = " + str(MySingleton.score + MySingleton.allscore))
	
	if MySingleton.currentLevel == 8:
		AudioServer.set_bus_volume_db(1,-72)
	else:
		AudioServer.set_bus_volume_db(1,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	amountOfChild = $".".get_child_count()
	$UI/scoreLabel.text = ("score = " + str(MySingleton.score + MySingleton.allscore))
	if amountOfChild == amountAtBeginning:
		_end_of_level()
		
func _on_walls_body_entered(body):
	if body is cnBall:
		body.direction = !body.direction
		
func _on_ceiling_area_body_entered(body):
	if body is cnBall:
		body._split()

func _end_of_level():
	MySingleton.allscore += MySingleton.score
	MySingleton.lives += 1
	MySingleton.currentLevel += 1
	get_tree().change_scene_to_file("res://scenes/levels/level" + str(MySingleton.currentLevel) + ".tscn")
