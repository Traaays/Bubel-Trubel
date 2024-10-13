extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ParallaxBackground/ParallaxLayer/Sprite2D.texture_rotation += 0.005 * delta * 60
