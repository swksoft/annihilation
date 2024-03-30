extends Node2D

@onready var polygon = %Polygon2D
@onready var collision = %CollisionPolygon2D

func _ready():
	var polygon_points = polygon.get_polygon()
	collision.set_polygon(polygon_points)


