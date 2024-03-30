extends Node
	
func display_number(value: float, position: Vector2): 
	if value == 0:
		return
	
	var number = Label.new()
	number.global_position = position
	number.text = str(value).pad_decimals(0)
	number.z_index = 5 # SALE AL FRENTE
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
		
	number.label_settings.font_color = color
	number.label_settings.font_size = 16
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 4
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.45
	).set_ease(tween.EASE_OUT)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(tween.EASE_IN).set_delay(0.2)
	
	await tween.finished
	number.queue_free()
