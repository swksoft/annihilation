extends Camera2D

@export var random_strength: float = 30.0
@export var shake_fade: float = 5.0

var rng = RandomNumberGenerator.new()

var thug_shaker_strength: float = 0.0

func apply_shake():
	thug_shaker_strength = random_strength
	
func _process(delta):
	if thug_shaker_strength > 0:
		thug_shaker_strength = lerpf(thug_shaker_strength, 0, shake_fade * delta)
		offset = random_offset()
	
func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-thug_shaker_strength, thug_shaker_strength), rng.randf_range(-thug_shaker_strength, thug_shaker_strength))
