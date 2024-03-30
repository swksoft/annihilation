extends Node2D

@export_range(-100, 100) var wind_force: int = 0

var current_turn

@onready var players = get_node("Players").get_children()

func _ready():
	RenderingServer.set_default_clear_color(Color("677e7c"))

	''' Start Turn '''
	TurnManager.start_game(players)
