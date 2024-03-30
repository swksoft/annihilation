extends RigidBody2D

# TODO: La pantalla debe vibrar al impactar un misil?
# TODO: Que la explosión tenga colores epilépticos XD

func _draw():
	draw_circle(Vector2.ZERO, 5, Color.BLACK)

func _ready():
	pass#var player_data = get_node("level").get_node("Player")
	
func _on_body_entered(body):
	print_debug("explosion")
	queue_free()
