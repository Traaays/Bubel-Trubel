extends Node2D

var score = 0
var allscore = 0
var highscore = 0
var lives = 0
var maxLives = 3

var currentLevel = 1

var skin = 1
var maxSkin = 7

@onready var discord_rpc = $DiscordRPC

#make an invisible skin as the last one, also make one unlockable by winning, maybe like a crown

func _process(delta):
	if allscore >= 100000:
		get_tree().quit()
	if Input.is_action_just_pressed("F4"):
		if DisplayServer.window_get_mode() == 4 or DisplayServer.window_get_mode() == 3:
			DisplayServer.window_set_mode(0)
		else:
			DisplayServer.window_set_mode(4)

		
