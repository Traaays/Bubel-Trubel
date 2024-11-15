extends Node2D

var number = 0
var numbertwo = 0

static var tutorial = false

func _ready():
	$".".modulate = Color(0.8,0.8,0.8)
	if tutorial == false:
		$dodgelabel.visible = true
		tutorial = true
	if MySingleton.lives == 1:
		MySingleton.lives += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextureRect.rotation += delta * 0.5


func _on_flip_timeout():
	if number % 3 == 0:
		$thefogiscoming.flip_h = !$thefogiscoming.flip_h
	if number % 4 == 0:
		$thefogiscoming.flip_v = !$thefogiscoming.flip_v
	number += 1


func _on_timer_timeout():
	print(numbertwo)
	numbertwo += 1
	match numbertwo:
		5:
			$dodgelabel.queue_free()
		12:
			var positions = [Vector2(40,120), Vector2(104,120), Vector2(152,120), Vector2(216,120)]
			for i in 4:
				var ball = cnBall.ballPL.instantiate()
				ball.size = 16
				ball.colour = "white"
				ball.rings = 8
				if i % 2 == 0:
					ball.direction = true
				else:
					ball.direction = false
				ball.position = positions[i]
				$testLevel.add_child(ball)
		36:
			transition()
			$".".modulate = Color(1,1,1)
		38:
			var positions = [Vector2(80,160), Vector2(180,160), Vector2(50,160), Vector2(210,160)]
			$Black.visible = false
			$testLevel/Devil.position = Vector2(128,$testLevel/Devil.position.y)
			for i in 4:
				var ball = cnBall.ballPL.instantiate()
				ball.size = 16
				ball.colour = "white"
				ball.rings = 8
				if i % 2 == 0:
					ball.direction = true
				else:
					ball.direction = false
				ball.position = positions[i]
				$testLevel.add_child(ball)
		45:
			transition()
			$".".modulate = Color(0.9,0.9,0.9)
		47:
			var positions = [Vector2(48,142),Vector2(216,142),Vector2(132,106),Vector2(132,142),Vector2(32,106),Vector2(200,106)]
			$Black.visible = false
			$testLevel/Devil.position = Vector2(20,$testLevel/Devil.position.y)
			for i in 6:
				var ball = cnBall.ballPL.instantiate()
				ball.size = 16
				ball.colour = "dim_gray"
				ball.rings = 4
				if i <= 2:
					ball.direction = true
				else:
					ball.direction = false
				ball.position = positions[i]
				$testLevel.add_child(ball)
		83:
			transition()
			$".".modulate = Color(0.8,0.8,0.8)
		85:
			var positions = [Vector2(60,136), Vector2(124,136),Vector2(196,136), Vector2(132,136)]
			$Black.visible = false
			$testLevel/Devil.position = Vector2(20,$testLevel/Devil.position.y)
			for i in 4:
				var ball = cnBall.ballPL.instantiate()
				ball.size = 32
				ball.colour = "white"
				ball.rings = 12
				if i <= 1:
					ball.direction = false
				else:
					ball.direction = true
				ball.position = positions[i]
				$testLevel.add_child(ball)
		93:
			transition()
			$".".modulate = Color(0.7,0.7,0.7)
		95:
			var positions = [Vector2(30,110), Vector2(230,120), Vector2(170,130), Vector2(150,140),Vector2(120,150),Vector2(210,160),Vector2(190,110)]
			$Black.visible = false
			$testLevel/Devil.position = Vector2(168,$testLevel/Devil.position.y)
			for i in 7:
				var ball = cnBall.ballPL.instantiate()
				ball.size = 16
				ball.colour = "white"
				ball.rings = 8
				if i % 2 == 0:
					ball.direction = true
				else:
					ball.direction = false
				ball.position = positions[i]
				$testLevel.add_child(ball)
		119:
			transition()
			$".".modulate = Color(0.5,0.5,0.5)
		121:
			var positions = [Vector2(16,124),Vector2(56,124),Vector2(96,124),Vector2(136,124),Vector2(176,124),Vector2(216,124),Vector2(36,124),Vector2(76,124),Vector2(116,124),Vector2(156,124),Vector2(196,124),Vector2(236,124)]
			$Black.visible = false
			$testLevel/Devil.position = Vector2(64,$testLevel/Devil.position.y)
			for i in 12:
				var ball = cnBall.ballPL.instantiate()
				ball.size = 8
				ball.colour = "white"
				ball.rings = 16
				if i <= 5:
					ball.direction = true
				else:
					ball.direction = false
				ball.position = positions[i]
				$testLevel.add_child(ball)


func transition():
	$Black.visible = true
	for child in $testLevel.get_children():
		if child is cnBall:
			child.queue_free()
	var ball = cnBall.ballPL.instantiate()
	ball.size = 8
	ball.colour = "white"
	ball.rings = 4
	ball.direction = true
	ball.position = Vector2(128,1)
	$testLevel.add_child(ball)
