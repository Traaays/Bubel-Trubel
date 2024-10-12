extends Node2D

@onready var pick = $pick
@onready var buttons = $buttons
@onready var mask = $Mask
@onready var logo = $logo
@onready var pif = $Mask/SubViewportContainer/SubViewport/Camera3D/AnimatedSprite3D
@onready var pifshadow = $Mask/SubViewportContainer/SubViewport/Camera3D/AnimatedSprite3D/AnimatedSprite3D2

@onready var skin = $skinLabel
@onready var highscore = $highscoreLabel

@onready var fullscreen = $fullscreenLabel
@onready var scalel = $scaleLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	skin.visible = false
	mask.visible = false
	fullscreen.visible = false
	scalel.visible = false
	MySingleton.lives = MySingleton.maxLives
	
	MySingleton.discord_rpc.refresh(true)
	MySingleton.discord_rpc.stamp_refresh()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if MySingleton.skin != 7:
		skin.text = str(MySingleton.skin)
	else:
		skin.text = "33% xd"
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
				match buttons.frame:
					0:
						get_tree().call_deferred("change_scene_to_file", "res://scenes/level1.tscn")
					1:
						if MySingleton.skin < MySingleton.maxSkin:
							MySingleton.skin += 1
						else: 
							MySingleton.skin = 1
						MySingleton.discord_rpc.refresh(true)
					2:
						if DisplayServer.window_get_mode() == 4 or DisplayServer.window_get_mode() == 3:
							DisplayServer.window_set_mode(0)
						else:
							DisplayServer.window_set_mode(4)
			1:
				match buttons.frame:
					0:
						buttons.frame = 1
						pick.frame = 0
						mask.visible = true
						skin.visible = true
						logo.visible = false
					1:
						buttons.frame = 2
						pick.frame = 0
						skin.visible = false
						fullscreen.visible = true
						scalel.visible = true
					2:
						if DisplayServer.window_get_mode() != 4 and DisplayServer.window_get_mode() != 3:
							if scalel.text == str(4):
								get_window().size = Vector2i(256,224)
							elif scalel.text == str(3):
								get_window().size = Vector2i(1024,896)
							elif scalel.text == str(2):
								get_window().size = Vector2i(768,672)
							else:
								get_window().size = Vector2i(512,448)
			2:
				match buttons.frame:
					0:
						get_tree().quit()
					1:
						buttons.frame = 0
						pick.frame = 0
						mask.visible = false
						skin.visible = false
						logo.visible = true
					2:
						buttons.frame = 1
						pick.frame = 0
						fullscreen.visible = false
						scalel.visible = false
						skin.visible = true
						logo.visible = false
	
	if get_window().size.x >= 1024 and get_window().size.y >= 896:
		scalel.text = str(4)
	elif get_window().size.x >= 768 and get_window().size.y >= 672:
		scalel.text = str(3)
	elif get_window().size.x >= 512 and get_window().size.y >= 448:
		scalel.text = str(2)
	else:
		scalel.text = str(1)
