extends Node

var round = 0
var max_round = 5
var current_turn: Object
var turn_order = []

func reorganize_turns(player_list, current_turn):
	var index = player_list.find(current_turn)
	var turn_order = player_list
	#turn_order.rotate(-index) # Rotar la lista para que el jugador con turno esté en el índice 0
	return turn_order

func start_game(player_list):
	start_next_turn(player_list)

func start_next_turn(player_list):
	round += 1
	if round > max_round:
		round = 0
	
	if round == 1:
		''' Determine who's first '''
		randomize()
		print(player_list)
		current_turn = player_list[randi() % player_list.size()]
		print_debug(current_turn)
		''' Reorganize List '''
		turn_order = reorganize_turns(player_list, current_turn)
		print(" NUEVO ORDEN MUNDIAL: ", turn_order)
		

	if round <= 0:
		end_game()
	
	print("RONDA #", round)
	print(current_turn, " empieza!!")
		
	return current_turn

func end_game():
	print("==== JUEGO TERMINADO ====")
	print("El ganador es:", get_winner())

func get_winner():
	if GLOBAL.p1_points > GLOBAL.p2_points:
		return GLOBAL.p1_name + "ha ganado!"
	elif GLOBAL.p1_points == GLOBAL.p2_points:
		return "Empate"
	else:
		return GLOBAL.p2_name + "ha ganado!"

func end_turn(player_list, player_name):
	if player_list.size() == 0:
		return
	
	start_next_turn(player_list)

func get_current_player(player_list):
	
	return player_list[current_turn]
