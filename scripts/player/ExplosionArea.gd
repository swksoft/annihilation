extends HitboxComponent

#@export_range(1, 1000) var points: int = 500
#@export var point_component : PointController
@export var hitbox_component: HitboxComponent
@export var hurtbox_component: HurtboxComponent

var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(0.0, 0.0, 1.0, 0.0)]

func _ready():
	get_tree().get_first_node_in_group("camera").apply_shake()

func _on_area_entered(area):
	print_debug("FUNCIONA")

func _on_body_entered(body):
	if body.has_method("damage"):
		var x1 = body.global_position.x
		var y1 = body.global_position.y
		var x2 = self.position.x
		var y2 = self.position.y
		#var point_modifier = (body.global_position - self.position)
		var point_modifier = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))
		var total_points = points / (point_modifier / 100)
		print(total_points)
		body.damage()

func _on_animation_player_animation_finished(anim_name):
	TurnManager.during_turn = false
	queue_free()

func _on_area_destruction_body_entered(body):
	if body.is_in_group("Terrain"):
		body.clip($AreaDestruction/DestructionPolygon)
