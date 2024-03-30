extends Node

var players = []
var current_turn = -1
var max_turns = 5
var scores = {} 

func start_game():
	start_next_turn()

func start_next_turn():
	if players.size() == 0:
		return
	
	current_turn += 1
	if current_turn >= players.size():
		current_turn = 0
	
	players[current_turn].start_turn()

	# Verificar si la partida ha terminado
	if current_turn == 0 and current_turn >= max_turns:
		end_game()

func end_game():
	var winner = get_winner()
	print("El ganador es:", winner)

func get_winner():
	var max_score = -1
	var winner = null
	for player in scores.keys():
		if scores[player] > max_score:
			max_score = scores[player]
			winner = player
	return winner

func end_turn(player_name, score_delta):
	if players.size() == 0:
		return
	
	scores[player_name] += score_delta
	start_next_turn()

func get_current_player():
	if players.size() == 0:
		return null
	
	return players[current_turn]
