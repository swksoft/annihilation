class_name Player extends CharacterBody2D

signal change_mode
signal turn_start
signal turn_end

@export_range(-108, 108) var rot = 90
@export_range(0, 5000) var force: int = 1000 # velocity.x

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum MODE{SHOOT_ATTACK, SHOOT_TP}
var current_mode = MODE.SHOOT_ATTACK

@onready var level_data = get_parent().get_parent()
@onready var cannon = $Cannon

func _ready():
	print_debug("CURRENT, ", current_mode)
	if get_name() == "Player1":
		$PlayerName.text = GLOBAL.p1_name
	elif get_name() == "Player2":
		$PlayerName.text = GLOBAL.p2_name
	
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
	emit_signal("turn_end")
	cannon.fire_missile(force, current_mode)

func _on_change_mode():
	print("pija")
