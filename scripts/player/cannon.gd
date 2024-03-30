extends Node2D

@export var missile_rigid_scene: PackedScene = preload("res://scenes/player/missile_rigid.tscn")

@onready var marker = $Sprite2D2/Marker2D

func _ready():
	pass
	#print(get_parent())
	#var player_data = get_parent()#.get_parent().get_node("Player")
	#print(player_data)
	#self.global_rotagion = deg_to_rad(player_data.rot)

func fire_missile(force):
	var missile_rigid = missile_rigid_scene.instantiate()
	missile_rigid.position = marker.global_position
	missile_rigid.linear_velocity.x = 1000 # Hardcoded
	#get_tree().get_root().add_child(missile_rigid)
	get_parent().get_parent().add_child(missile_rigid)
	print_debug("Disparar misil")
