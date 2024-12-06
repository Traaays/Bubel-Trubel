extends Node2D

var amountAtBeginning = 0
var queued = false
var walking = false

func _ready():
	if MySingleton.lives == 1:
		MySingleton.lives += 1
	if MySingleton.gotToBroweser == true:
		queued = true
		$backgroun.queue_free()
		$Devil.position = Vector2(2120,152)
		$Devil/Camera2D.offset = Vector2(40,-40)
		for child in get_children():
			if child is cnBall:
				child.queue_free()
		$Devil/ShootArea2D/MeshInstance2D.texture = load("res://assets/balls/black.tres")
		$broweser/leftright.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if queued == false:
		$backgroun/Spiral.rotation += delta
		$backgroun/Vbackground.rotation += delta * 0.7
		$backgroun/Bacckground4.rotation += delta * 0.9
	if walking == true:
		$Devil.velocity.x = 90

func _on_area_2d_body_entered(body):
	if body is cnDevil:
		MySingleton.gotToBroweser = true
		queued = true
		$backgroun.queue_free()
		$Devil.position = Vector2(2120,152)
		$Devil/Camera2D.offset = Vector2(40,-40)
		$broweser/leftright.start()
		$Devil/ShootArea2D/MeshInstance2D.texture = load("res://assets/balls/black.tres")
		for child in get_children():
			if child is cnBall:
				child.queue_free()


func _on_axe_2d_body_entered(body):
	if body is cnDevil:
		$doneTImer.start()
		$Node2D/CollisionShape2D.position.x = 304
		$ColorRect3.queue_free()
		$broweser/CollisionShape2D.set_deferred("disabled", "true")
		$broweser.scale.y = -21.835
		if $broweser.position.x > 2380:
			$broweser.position.x = 2380
		$axe.queue_free()
		walking = true
			


func _on_broweser_checker_body_entered(body):
	if body is broweser:
		MySingleton.die()


func _on_done_t_imer_timeout():
	MySingleton.allscore += MySingleton.score
	get_tree().change_scene_to_file("res://scenes/levels/end.tscn")
