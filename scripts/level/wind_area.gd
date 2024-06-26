extends Area2D

signal new_wind(wind)

@export_range(-0.7, 0.7) var wind_intensity: float = 0.0

func change_wind():
	randomize()
	var wind_modifier = randf_range(-0.7, 0.7)
	gravity_direction.x = wind_intensity + wind_modifier
	emit_signal("new_wind", wind_modifier)

func _ready():
	change_wind()
	# FIXME: Viento no cambia XD
