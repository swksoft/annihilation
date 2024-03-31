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
	var missile_rigid : Missile
	
	match current_mode:
		Player.MODE.SHOOT_ATTACK:
			missile_rigid = missile_rigid_scene.instantiate() as Missile
		Player.MODE.SHOOT_TP:
			missile_rigid = missile_tp_scene.instantiate()
	missile_rigid.position = marker.global_position
	var direction = Vector2(cos(marker.global_rotation), sin(marker.global_rotation))
	missile_rigid.linear_velocity = power * direction
	missile_rigid.player = get_parent()
	get_parent().get_parent().add_child(missile_rigid)
