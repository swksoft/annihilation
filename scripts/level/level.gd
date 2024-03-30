extends Node2D

@export var screen_message: PackedScene
@export_range(-100, 100) var wind_force: int = 0

var current_turn

@onready var players = get_node("Players").get_children()

func display_message():
	var message = screen_message.instantiate()
	message.message_text = "Begin!"
	add_child(message)

func _ready():
	RenderingServer.set_default_clear_color(Color("677e7c"))
	
	''' Who's who?????? '''
	for i in players:
		match i.get_name():
			"Player1":
				var player1 = get_node("Players").get_node("Player1")
			"Player2":
				var player2 = get_node("Players").get_node("Player2")
		
	print_debug(players)
	
	''' Determine who's first '''
	current_turn = players[randi() % players.size()]
	print_debug("EL PRIMER TURNO VA PARA: ", current_turn.get_name())
	''' Screen Message '''
	#display_message()
	''' Start Turn '''
	TurnManager.start_game()
