class_name Player extends CharacterBody2D

signal change_mode
signal turn_start
signal turn_end
signal change_points

@export_range(-108, 108) var rot = 90
@export_range(0, 5000) var force: int = 1000 # velocity.x
@export var player_index = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum MODE{SHOOT_ATTACK, SHOOT_TP}
var current_mode = MODE.SHOOT_ATTACK
var p_name
var can_shoot = false
var player_points = 0

@onready var level_data = get_parent().get_parent()
@onready var cannon = $Cannon
@onready var point_component: PointController = $point_component

func my_turn(is_it):
	if is_it:
		$Turn.visible = true
		#print("activate")
	else:
		$Turn.visible = false
		#print("deactivate")

func _ready():
	if get_name() == "Player1":
		p_name = GLOBAL.p1_name
		$PlayerName.text = p_name
	elif get_name() == "Player2":
		p_name = GLOBAL.p2_name
		$PlayerName.text = p_name
	
	# TODO: Ajustar
	''' Skin '''
	#var atlas_texture = AtlasTexture.new()
	#atlas_texture.atlas = load("res://assets/tiles/tilemap_packed.png")
	
	''' Rotation '''
	cannon.rotation_degrees = rot

func _physics_process(delta):
	cannon.rotation_degrees = rot
	
	if not is_on_floor():
		velocity.y += gravity
	
	move_and_slide()
	
func attack():
	my_turn(false)
	emit_signal("turn_end")
	cannon.fire_missile(force, current_mode)

func get_points(total_points, player_name):
	print(player_name)
	if player_name == "Player1":
		
		GLOBAL.p1_points += total_points
		
		#var p1_points = GLOBAL.p1_points
		#print(GLOBAL.p1_points)
		emit_signal("change_points")
	elif player_name == "Player2":
		GLOBAL.p2_points += total_points
		#print(GLOBAL.p2_points)
		emit_signal("change_points")

func damage():
	var sprite = [$Sprite2D3, $Sprite2D, $Sprite2D2]
	var canon_sprite = cannon.get_node("Sprite2D")
	#var sprite = [$Sprite2D3, $Sprite2D, $Sprite2D2, canon_sprite, canon_sprite.get_node("Sprite2D2")]
	$Timer.start()
	for i in sprite:
		i.material.set_shader_parameter("opacity", 0.7)
		i.material.set_shader_parameter("r", 1.0)
		i.material.set_shader_parameter("g", 0.0)
		i.material.set_shader_parameter("b", 0.0)
		i.material.set_shader_parameter("mix_color", 0.7)

func _on_timer_timeout():
	var canon_sprite = cannon.get_node("Sprite2D")
	var sprite = [$Sprite2D3, $Sprite2D, $Sprite2D2, canon_sprite, canon_sprite.get_node("Sprite2D2")]
	for i in sprite:
		i.material.set_shader_parameter("opacity", 1.0)
		i.material.set_shader_parameter("mix_color", 0.0)

func _on_point_component_point_changed():
	print("me diste")
