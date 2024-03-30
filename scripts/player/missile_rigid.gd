extends RigidBody2D
class_name Missile

# TODO: La pantalla debe vibrar al impactar un misil?
# TODO: Que la explosión tenga colores epilépticos XD

@export var explosion_scene: PackedScene = preload("res://scenes/player/explosion_area.tscn")

func _draw():
	draw_circle(Vector2.ZERO, 5, Color.BLACK)

func explosion():
	var explosion = explosion_scene.instantiate()
	explosion.position = global_position
	get_parent().add_child(explosion)
	queue_free()
	
func _on_body_entered(body):
	explosion()
	
func _on_area_explosiva_area_entered(area):
	if area.is_in_group("Terrain"):
		explosion()

func _on_timer_timeout():
	explosion()
