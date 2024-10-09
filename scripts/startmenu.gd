extends Node2D

@onready var pick = $pick
@onready var buttons = $buttons
@onready var mask = $Mask
@onready var logo = $logo
@onready var pif = $Mask/SubViewportContainer/SubViewport/Camera3D/AnimatedSprite3D
@onready var pifshadow = $Mask/SubViewportContainer/SubViewport/Camera3D/AnimatedSprite3D/AnimatedSprite3D2

@onready var skin = $skinLabel
@onready var level = $levelLabel
@onready var highscore = $highscoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	skin.visible = false
	level.visible = false
	mask.visible = false
	MySingleton.lives = MySingleton.maxLives

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if MySingleton.skin != 6:
		skin.text = str(MySingleton.skin)
	else:
		skin.text = "33% xd"
	level.text = str(MySingleton.currentLevel)
	highscore.text = ("highscore: " + str(MySingleton.highscore))
	pif.rotation.y -= 0.02
	pif.animation = str(MySingleton.skin) + "run"
	pifshadow.animation = str(MySingleton.skin) + "run"

	if Input.is_action_just_pressed("Select"):
		if pick.frame <= 1:
			pick.frame += 1
		else:
			pick.frame = 0
	if Input.is_action_just_pressed("Start"):
		match pick.frame:
			0:
				if buttons.frame == 0:
					get_tree().change_scene_to_file("res://scenes/level1.tscn")
				else:
					if MySingleton.skin < MySingleton.maxSkin:
						MySingleton.skin += 1
					else: 
						MySingleton.skin = 1
			1:
				if buttons.frame == 0:
					buttons.frame = 1
					pick.frame = 0
					mask.visible = true
					#level.visible = true
					skin.visible = true
					logo.visible = false
				else:
					#if MySingleton.currentLevel < MySingleton.maxLevel:
						#MySingleton.currentLevel += 1
					#else: 
						#MySingleton.currentLevel = 1
					pass
			2:
				if buttons.frame == 0:
					get_tree().quit()
				else:
					buttons.frame = 0
					pick.frame = 0
					mask.visible = false
					level.visible = false
					skin.visible = false
					logo.visible = true
