extends Control

@onready var pause_menu = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Start"):
		if get_tree().paused == false:
			get_tree().paused = true
			pause_menu.visible = true
		else:
			get_tree().paused = false
			pause_menu.visible = false
		
