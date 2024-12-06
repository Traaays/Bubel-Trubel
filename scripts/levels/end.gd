extends Node2D

@onready var pif = $Mask/SubViewportContainer/SubViewport/Camera3D/AnimatedSprite3D
@onready var pifshadow = $Mask/SubViewportContainer/SubViewport/Camera3D/AnimatedSprite3D/AnimatedSprite3D2

# Called when the node enters the scene tree for the first time.
func _ready():
	MySingleton.maxSkin = 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pif.rotation.y -= 0.02 * delta * 60
	pif.animation = "8run"
	pifshadow.animation = "8run"
	MySingleton.allscore = 0
	if Input.is_action_just_pressed("Shoot") or Input.is_action_just_pressed("Select") or Input.is_action_just_pressed("Start"):
		get_tree().change_scene_to_file("res://scenes/startmenu.tscn")
