extends Node2D

var number = 0

var done = false

var oldchildcount
var c = 0.9098
var a = 1

func _ready():
	oldchildcount = $testLevel.get_child_count()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if oldchildcount != $testLevel.get_child_count() and done == false:
		$ColorRect2.modulate = Color(c,c,c,a)
		$testLevel.modulate = Color(c,c,c)
		c = c - 0.01
		a = a - 0.01
		oldchildcount = $testLevel.get_child_count()
	
	if $testLevel.get_child_count() == 10 and done == false:
		donefunc()
		
	$TextureRect.rotation += delta * 2

func donefunc():
	done = true
	$ColorRect2.modulate = Color(0,0,0,0)
	for children in $testLevel.get_children():
		if children is cnBall:
			children.colour = "dim_gray"
			children.popcolour = Color.DIM_GRAY
			children.mesh.texture = load("res://assets/balls/dim_gray.tres")

func _on_flip_timeout():
	if number % 3 == 0:
		$thefogiscoming.flip_h = !$thefogiscoming.flip_h
	if number % 4 == 0:
		$thefogiscoming.flip_v = !$thefogiscoming.flip_v
	number += 1


func _on_iftooslow_timeout():
	donefunc()
