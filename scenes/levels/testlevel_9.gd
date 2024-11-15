extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$testLevel/Devil.position = Vector2(64,$testLevel/Devil.position.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
