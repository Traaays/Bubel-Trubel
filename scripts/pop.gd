extends Node2D

@onready var pop2d = $"."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pop2d.frame == 4:
		queue_free()
