extends CharacterBody2D

var lado = 1
var vel = Vector2()
var speed = 200

var queda = 1

func _ready():
	$quack.wait_time = randf_range(0.8,2)
	randomize()
	$movimento.wait_time = randf_range(0.4,2)
	$anima.wait_time = randf_range(0.6,1)
	
func _process(delta):
	#horizontal
	position.x += speed*lado*delta
	
	#vertical
	position.y -= 240*queda*delta
	
	#espelhamento
	if lado < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false


func _on_movimento_timeout():
	lado = lado*(-1)


func _on_anima_timeout():
	if $AnimatedSprite2D.animation == "cima":
		$AnimatedSprite2D.animation = "lado"
	elif $AnimatedSprite2D.animation == "lado":
		$AnimatedSprite2D.animation = "cima"
		
func mata():
	$AnimatedSprite2D.animation = "susto"
	$morte.start()

func _on_susto_timeout():
	$quack.stop()
	$AnimatedSprite2D.animation = "morte"
	queda = -1
	lado = 0


func _on_quack_timeout():
	$audio.play()
