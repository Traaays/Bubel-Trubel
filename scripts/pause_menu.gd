extends Control

@onready var pause_menu = $"."
@onready var label = $Label
@onready var startTimer = $StartTimer


var startTimerAmount = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	#paused.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Start") and startTimer.is_stopped():
		if get_tree().paused == false:
			get_tree().paused = true
			pause_menu.visible = true
		else:
			get_tree().paused = false
			pause_menu.visible = false
	if Input.is_action_just_pressed("Select") and startTimer.is_stopped() and get_tree().paused == true:
		get_tree().paused = false
		if MySingleton.highscore < MySingleton.allscore + MySingleton.score:
			MySingleton.highscore = MySingleton.allscore + MySingleton.score
		MySingleton.allscore = 0
		get_tree().call_deferred("change_scene_to_file", "res://scenes/startmenu.tscn")
	if Input.is_action_just_pressed("Reset") and startTimer.is_stopped() and get_tree().paused == true:
		get_tree().paused = false
		MySingleton.lives -= 1
		if MySingleton.highscore < MySingleton.allscore + MySingleton.score:
			MySingleton.highscore = MySingleton.allscore + MySingleton.score
		get_tree().call_deferred("reload_current_scene")


func _on_start_timer_timeout():
	if startTimerAmount >= 1:
		label.text = str(startTimerAmount) + "."
		startTimerAmount -= 1
		startTimer.start()
	else:
		get_tree().paused = false
		pause_menu.visible = false
		label.text = "paused."
