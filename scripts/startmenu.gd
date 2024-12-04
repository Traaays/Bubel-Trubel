extends Node2D

@onready var pick = $pick
@onready var buttons = $buttons
@onready var mask = $Mask
@onready var logo = $logo
@onready var pif = $Mask/SubViewportContainer/SubViewport/Camera3D/AnimatedSprite3D
@onready var pifshadow = $Mask/SubViewportContainer/SubViewport/Camera3D/AnimatedSprite3D/AnimatedSprite3D2

@onready var skin = $skinNumba
@onready var highscore = $highscoreLabel

@onready var fullscreen = $fullscreenNumba
@onready var scalel = $scaleNumba

# Called when the node enters the scene tree for the first time.
func _ready():
	MySingleton.lives = MySingleton.maxLives
	MySingleton.currentLevel = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	skin.frame = cnDevil.skin
	highscore.text = ("highscore: " + str(MySingleton.highscore))
	pif.rotation.y -= 0.02 * delta * 60
	pif.animation = str(cnDevil.skin) + "run"
	pifshadow.animation = str(cnDevil.skin) + "run"
	check_display()

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
						get_tree().call_deferred("change_scene_to_file", "res://scenes/levels/level1.tscn")
					1:
						if cnDevil.skin < MySingleton.maxSkin:
							cnDevil.skin += 1
						else: 
							cnDevil.skin = 1
					2:
						MySingleton.fullscreen()
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
							if scalel.frame == 4:
								get_window().size = Vector2i(256,224)
							elif scalel.frame == 3:
								get_window().size = Vector2i(1024,896)
							elif scalel.frame == 2:
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

func check_display():
	if get_window().size.x >= 1024 and get_window().size.y >= 896:
		scalel.frame = 4
	elif get_window().size.x >= 768 and get_window().size.y >= 672:
		scalel.frame = 3
	elif get_window().size.x >= 512 and get_window().size.y >= 448:
		scalel.frame = 2
	else:
		scalel.frame = 1
	if DisplayServer.window_get_mode() == 4 or DisplayServer.window_get_mode() == 3:
		fullscreen.frame = 1
	else:
		fullscreen.frame = 0
