extends Node2D

var score = 0
var allscore = 0
var highscore = 0
var lives = 0
var maxLives = 3

var currentLevel = 1
var maxLevel = 2

var skin = 1
var maxSkin = 5
#make an invisible skin as the last one, also make one unlockable by winning, maybe like a crown

# Called when the node enters the scene tree for the first time.
func _ready():
	lives = maxLives


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
