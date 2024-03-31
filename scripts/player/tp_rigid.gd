extends Missile

# TODO: Esto debe desaparecer cuando se sale de la pantalla

@onready var player = get_parent().get_parent()

func explosion():
	player.position = self.position
	queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 5, Color("#ffff55"))
