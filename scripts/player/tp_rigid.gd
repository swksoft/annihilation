extends Missile

@onready var player = get_parent().get_parent()

func explosion():
	player.global_position = self.position
	queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 5, Color("#ffff55"))
