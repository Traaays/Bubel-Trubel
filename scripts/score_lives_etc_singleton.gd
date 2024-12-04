extends Node2D

var score = 0
var allscore = 0
var highscore = 0

var lives = 3
var maxLives = 3

var currentLevel = 1

var maxSkin = 7

#make an invisible skin as the last one, also make one unlockable by winning, maybe like a crown

func _process(delta):
	if Input.is_action_just_pressed("F4"):
		fullscreen()

func fullscreen():
	if DisplayServer.window_get_mode() == 4 or DisplayServer.window_get_mode() == 3:
		DisplayServer.window_set_mode(0 as DisplayServer.WindowMode)
	else:
		DisplayServer.window_set_mode(4 as DisplayServer.WindowMode)

func die():
	if MySingleton.highscore < MySingleton.allscore + MySingleton.score:
		MySingleton.highscore = MySingleton.allscore + MySingleton.score
	if MySingleton.lives > 1:
		MySingleton.lives -= 1
		get_tree().call_deferred("reload_current_scene")
	else:
		MySingleton.allscore = 0
		get_tree().call_deferred("change_scene_to_file", "res://scenes/startmenu.tscn")
