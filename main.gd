extends Node2D

var patosnatela
var pato = preload("res://pato.tscn")

var flyaway = 0
var capturados = 0

func _ready():
	$gerarpato.start()
	

func _process(delta):
	$Hud/Label.text = str(capturados)
	$alvo.position.x = get_global_mouse_position().x
	$alvo.position.y = get_global_mouse_position().y

func nasce():
	var novopato = pato.instantiate()
	add_child(novopato)
	novopato.position.x = randf_range(50,700)
	novopato.position.y = 700

func _on_gerarpato_timeout():
	patosnatela = int(randf_range(1,4))
	for n in patosnatela:
		nasce()

func _on_espera_timeout():
	$novo_turno.play()
	$gerarpato.start()



func _on_chao_body_entered(body):
	$colidiu.play()
	capturados += 1
	patosnatela -= 1
	atualizarturno()

func _on_topo_body_entered(body):
	$flayaway.play()
	flyaway = 1
	patosnatela -= 1
	atualizarturno()

func atualizarturno():
	print(patosnatela)
	if patosnatela == 0:
		print("patos na tela 0")
		$espera.start()
		if flyaway == 1:
			$cao.play("rindo")
			$cao_rindo.play()
			print("rindo")
			flyaway = 0
			print(flyaway)
			capturados = 0
		else:
			print("capturado")
			$cao.play("capturado")
			$cao_captura.play()
