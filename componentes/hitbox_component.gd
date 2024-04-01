extends Area2D
class_name HitboxComponent

@export_range(1, 1000) var points: int = 500

@onready var point_component : PointController

func _on_hit():
	print("Hit!")
	point_component.point_changed.connect(on_point_changed)

func on_point_changed():
	print("puntos")
	pass
