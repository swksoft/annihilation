extends Node2D

# AQUI SE VAN A GESTIONAR LOS TURNOS

signal round_start
signal round_end
signal game_end #avengers
signal turn_start(current_player)

@export_range(-100, 100) var wind_force: int = 0

var ready_player1 = false
var ready_player2 = false
var ready_both = ready_player1 and ready_player2
var is_battling = false # Activa/Desactiva hud y controles
var current_turn = 0

''' 1) Obtain player list '''
@onready var players = get_node("Players").get_children()
@onready var total_turns = players.size()
@onready var turn_order = players

func _ready():
	RenderingServer.set_default_clear_color(Color("677e7c"))

	#TurnManager.start_game(players)
	
	#next_round()
	turn_order[current_turn]
	if players.size() == 0:
		emit_signal("game_end")
	else:
		''' 2) Obtain player (random) turn order'''
		turn_order.shuffle()
		''' 3) Start Round '''
		next_round()

''' 3) Start Round '''
func next_round():
	TurnManager.round += 1
	
	if TurnManager.round > TurnManager.max_round:
		''' 6) Repeat rounds until end'''
		emit_signal("game_end")
	else:
		print("\n===== RONDA #", TurnManager.round, "\n")
		''' 4) Start Player Turn'''
		next_turn()
		#emit_signal("round_start")

''' 4) Start Player Turn'''
func next_turn():
	is_battling = true
	
	if current_turn < turn_order.size():
		emit_signal("turn_start", turn_order[current_turn]) # Manda señal a hud
		return
	
	#for current_turn in total_turns:
		#print("TURNO ", current_turn+1, ": ", turn_order[current_turn])
		#emit_signal("turn_start", turn_order[current_turn]) # Manda señal a hud
		##current_turn += 1
		#return
	
	current_turn = 0
	
	next_round()

''' 5) Advance turn until end'''
func _on_ui_end_turn():
	current_turn += 1
	print("\n")
	is_battling = false
	next_turn()

''' 6) Repeat rounds until end'''
func _on_game_end():
	#get_tree().change_scene_to_file("res://scenes/hud/main_menu.tscn")
	get_tree().call_deferred("change_scene_to_file", "res://scenes/hud/main_menu.tscn")

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

