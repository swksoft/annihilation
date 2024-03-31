extends Missile

# TODO: Esto debe desaparecer cuando se sale de la pantalla

func explosion():
	player.global_position = self.global_position
	queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 5, Color("#ffff55"))
