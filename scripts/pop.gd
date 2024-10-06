extends Node2D

@onready var pop2d = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pop2d.frame == 4:
		queue_free()
