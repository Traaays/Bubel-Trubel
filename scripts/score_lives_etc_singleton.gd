extends Node2D

var score = 0
var allscore = 0
var highscore = 0
var lives = 0
var maxLives = 3

var currentLevel = 1
var maxLevel = 2

var skin = 1
var maxSkin = 6
#make an invisible skin as the last one, also make one unlockable by winning, maybe like a crown

func _process(delta):
	if allscore >= 100000:
		get_tree().quit()
