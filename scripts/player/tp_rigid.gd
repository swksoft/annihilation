extends Missile

func explosion():
	var camera_pos = get_tree().get_first_node_in_group("camera").global_position
	var camera_limits = get_canvas_transform().affine_inverse().basis_xform(get_viewport_rect().size)
	if self.global_position.x > camera_pos.x && self.global_position.x < camera_limits.x && self.global_position.y < camera_limits.y:
		player.global_position = self.global_position
		TurnManager.during_turn = false
	queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 5, Color("#ffff55"))
