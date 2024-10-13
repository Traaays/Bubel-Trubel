extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$testLevel/Devil.modulate = Color(0,0,0)
	$testLevel/Devil.shadow.visible = false


func _on_timer_timeout():
	$testLevel/pause_menu.modulate = Color(0,0,0)
