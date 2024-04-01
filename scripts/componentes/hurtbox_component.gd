extends Area2D
class_name HurtboxComponent

@export var stats_component: StatsComponent
@export var point_component: PointController
@export var hitbox_component: HitboxComponent

#var floating_text_scene: PackedScene = preload("res://scenes/UI/floating_text.tscn")

func _on_area_entered(area: Area2D):
	if area is HitboxComponent:
		var player = area.get_parent()
		
		''' Cálculo choto de puntos '''
		var points = 500
		var x1 = area.global_position.x
		var y1 = area.global_position.y
		var x2 = self.position.x
		var y2 = self.position.y
		var point_modifier = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))
		var total_points = points / (point_modifier / 100)
		#player.player_index
		#player.damage()
		#print(total_points)
		print_debug("PLASHER: ", player.player_index)
		
