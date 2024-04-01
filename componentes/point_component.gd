extends Node
class_name PointController

signal point_changed

func get_points(point_amount: float):
	print("Obtiene puntos")
	point_changed.emit()

#health_component.health_changed.connect(on_health_changed)
