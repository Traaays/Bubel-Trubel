extends Node2D

var score
var highscore
var lives = 5

var currentLevel = 1
var maxLevel = 2

var skin = 1
var maxSkin = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _switch_skin(as2d):
	match skin:
		1:
			as2d.sprite_frames = load("res://assets/pifpafs/pifpafbasic.tres")
		2:
			as2d.sprite_frames = load("res://assets/pifpafs/pifpafevil.tres")
