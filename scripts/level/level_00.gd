extends Node2D

@onready var polygon = %Polygon2D
@onready var collision = %CollisionPolygon2D

func _ready():
	var polygon_points = polygon.get_polygon()
	collision.set_polygon(polygon_points)

func clip(poly):
	var offset_poly = Polygon2D.new()
	offset_poly.global_position = Vector2.ZERO
	
	var new_values = []
	for point in poly.polygon:
		new_values.append(point+poly.global_position)
		offset_poly.polygon = PackedVector2Array(new_values)
		var res = Geometry2D.clip_polygons(polygon.polygon, offset_poly.polygon)
		
		polygon.polygon = res[0]
		polygon.set_deferred("polygon", res[0])

		collision.call_deferred("set_polygon", res[0])
		#collision.set_polygon(res[0])
		
		
		
		polygon.set_deferred("polygon", res[0])
		#collision.set_deferred("polygon", res[0])
