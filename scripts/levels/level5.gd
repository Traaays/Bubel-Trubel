extends Node2D

var texts = 0

func _process(delta):
	if texts != 9:
		$Icon.position.y += delta * 5
	else:
		$Icon.position.x = move_toward($Icon.position.x, 13, delta * 50)
	

func _on_timer_timeout():
	match texts:
		0:
			$"Texts/cannot open2".visible = true
			$timer.start(3)
		1:
			$"Texts/cannot open3".visible = true
			$timer.start(1)
		2:
			$"Texts/c++ error".text = "gdscript error"
			$"Texts/cannot open4".visible = true
			$timer.start(0.5)
		3:
			$"Texts/cannot open5".visible = true
			$timer.start(0.1)
		4:
			$"Texts/cannot open6".visible = true
			$timer.start(0.11)
		5:
			$"Texts/cannot open7".visible = true
			$timer.start(0.08)
		6:
			$"Texts/c++ error".text = "c# error"
			$"Texts/cannot open8".visible = true
			$timer.start(1)
		7:
			$Texts.visible = false
			$timer.start(5)
		8:
			$timer.start(5)
		9:
			$colon3.visible = true
			$timer.start(1)
		10:
			$colon3.visible = false
			$timer.start(32)
		11:
			$colon3.text = "youre pretty slow!"
			$colon3.visible = true
			$timer.start(10)
		12:
			$colon3.text = "youre pretty"
	texts += 1
