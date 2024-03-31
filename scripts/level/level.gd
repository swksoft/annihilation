extends Node2D

signal round_start
signal round_end
signal game_end #avengers

@export_range(-100, 100) var wind_force: int = 0

var current_turn
var ready_player1 = false
var ready_player2 = false
var ready_both = ready_player1 and ready_player2

@onready var players = get_node("Players").get_children()

func _ready():
	RenderingServer.set_default_clear_color(Color("677e7c"))

	''' Start Turn '''
	TurnManager.start_game(players)
	
	next_round()

func next_round():
	if TurnManager.round > TurnManager.max_round:
		emit_signal("game_end")
	else:
		emit_signal("round_start")

func next_turn():
	pass

func _on_game_end():
	get_tree().change_scene_to_file("res://scenes/hud/main_menu.tscn")

func _on_round_end():
	# Es llamada luego de que ambos jugadores llamen a "turn_ended"
	next_round()

func _on_player_1_turn_end():
	if ready_both:
		emit_signal("round_end")
	else:
		next_turn()
		
func _on_player_2_turn_end():
	if ready_both:
		emit_signal("round_end")
	else:
		next_turn()


func _on_ui_give_up():
	emit_signal("game_end")
