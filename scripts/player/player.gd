extends CharacterBody2D

@export_range(-195, 18) var rot = -90
@export_range(0, 5000) var force: int = 1000 # velocity.x

@onready var level_data = get_parent().get_parent()
@onready var cannon = $Cannon

func _ready():
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
	
	

func attack():
	cannon.fire_missile(force)
