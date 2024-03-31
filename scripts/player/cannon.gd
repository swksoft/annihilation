class_name Cannon extends Node2D

@export var missile_rigid_scene: PackedScene = preload("res://scenes/player/missile_rigid.tscn")
@export var missile_tp_scene: PackedScene = preload("res://scenes/player/tp_rigid.tscn")

var power = 0

@onready var marker = $Sprite2D/Sprite2D2/Marker2D

func _ready():
	pass
	#print(get_parent())
	#var player_data = get_parent()#.get_parent().get_node("Player")
	#print(player_data)
	#self.global_rotagion = deg_to_rad(player_data.rot)

func fire_missile(force, current_mode):
	if current_mode:
		var missile_rigid = missile_rigid_scene.instantiate() as Missile
		missile_rigid.position = marker.global_position
		var direction = Vector2(cos(marker.global_rotation), sin(marker.global_rotation))
		missile_rigid.linear_velocity = power * direction
		#get_tree().get_root().add_child(missile_rigid)
		get_parent().get_parent().add_child(missile_rigid)
		print_debug("Disparar misil")
	if current_mode:
		var missile_tp = missile_tp_scene.instantiate() as Missile 
		missile_tp.position = marker.global_position
		get_parent().get_parent().add_child(missile_tp)
		print_debug("Disparar tp")
