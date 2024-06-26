extends Control

# TODO: Centrar texto del nodo Edit
# TODO: Capturar pantalla al momento de disparar y al momento de impacto con get_viewport().queue_screen_capture()
# TODO: Agregar limites para los lineedit

signal give_up
signal change_mode
signal end_turn

var can_shoot: bool

@export var screen_message: PackedScene = preload("res://scenes/hud/screen_message.tscn")

var deactivate_controls: bool = false
var current_player: Player

@onready var level_data = get_parent().get_parent().get_node("Level")
@onready var player_data = get_parent().get_node("Players").get_children()
@onready var wind = get_parent().get_node("Camera2D").get_node("WindArea")

@export var power_input : LineEdit

var previous_settings : Dictionary

func disable_all_buttons():
	get_tree().call_group("Button", "set_disabled", true)
	get_tree().call_group("Edit", "set_editable", not true)

func _ready():
	
	set_previous_settings()
	''' OBTENER ESCENA DE TODOS LOS PLAYERS '''
	#current_player = player_data[0]  # TODO: esto debe cambiar
	#%AngleEdit.text = str(current_player.rot)
	#change_power()
	#%CheckButton.button_pressed = true
	#print("PLAYER DATA: ", typeof(player_data[0]))
	# TODO: Cargar puntuación de jugador 1 y 2
	# TODO: Cargar valores fuerza y ángulo de jugador 1 y 2
	# TODO: Cargar puntuación de jugador 1 y 2
	# TODO: 	Animación de ronda
	# TODO: botones
	# TODO: Quitar/Brindar acceso a controles
	# TODO: Cargar Nombres
	# TODO: CheckButton debe estar siempre activado al inicio de ronda
	%P1Name.text = GLOBAL.p1_name
	%P2Name.text = GLOBAL.p2_name
	#get_tree().call_group("Button", "set_disabled", true)
	#get_tree().call_group("Edit", "set_editable", not true)
	
	''' Mensaje inicial '''
	#await display_message("Begin!")
	
func display_message(text: String):
	var message = screen_message.instantiate()
	message.message_text = str(text)
	add_child(message)

func _process(_delta):
	if !can_shoot:
		if TurnManager.during_turn:
			return
		else:
			emit_signal("end_turn")
		return
	
	# TODO: Quiero que todos los botones se muestren presionados cuando se realiza un input del teclado (jugo)
	if Input.is_action_just_pressed("fire"):
		#%Button.button_pressed = true
		_on_button_pressed()
	elif Input.is_action_just_pressed("give_up"): _on_give_up_button_pressed()
	elif Input.is_action_pressed("inc_angle"): _on_angle_less_button_pressed()
	elif Input.is_action_pressed("dec_angle"): _on_angle_more_button_pressed()
	elif Input.is_action_just_pressed("inc_power"): _on_power_less_button_pressed()
	elif Input.is_action_just_pressed("dec_power"): _on_power_more_button_pressed()
	elif Input.is_action_just_pressed("change_mode"):
		if %CheckButton.button_pressed:
			%CheckButton.button_pressed = false
		else:
			%CheckButton.button_pressed = true
	
func change_power():
	var cannon = current_player.get_node("Cannon") as Cannon
	cannon.power = float(power_input.text)
	

func _on_button_pressed():
	if !can_shoot: return
	can_shoot = false
	#current_player.my_turn(true)
	#print_debug("fire_button")
	_on_check_button_toggled(%CheckButton.button_pressed)
	change_power()
	current_player.attack()
	var previous_temp = previous_settings
	set_previous_settings()
	
	apply_settings(previous_temp)
	# TODO: Emite una señal al jugador correspondiente

func _on_give_up_button_pressed():
	display_message("You gave up! Now your oponent is the king!")
	emit_signal("give_up")
	
''' ANGLE BUTTONS '''
func _on_angle_less_button_pressed():
	#print_debug("increase_angle")
	%AngleEdit.text = str(current_player.cannon.global_rotation_degrees - 5)
	angle_check()
	current_player.rot = float(%AngleEdit.text)
func _on_angle_more_button_pressed():
	#print_debug("decrease_angle")
	%AngleEdit.text = str(current_player.cannon.global_rotation_degrees + 5)
	angle_check()
	current_player.rot = float(%AngleEdit.text)
func _on_angle_edit_text_changed(new_text):
	angle_check()
	current_player.rot = float(%AngleEdit.text)

''' POWER BUTTONS '''
func _on_power_less_button_pressed():
	power_input.text = str(int(power_input.text) - 50)
	change_power()
func _on_power_more_button_pressed():
	power_input.text = str(int(power_input.text) + 50)
	change_power()

func _on_power_edit_text_changed(new_text):
	power_input.text = str(int(power_input.text))
	change_power()

''' SHOOT MODE '''
func _on_check_button_toggled(toggled_on):
	var mode
	if toggled_on:
		current_player.current_mode = Player.MODE.SHOOT_ATTACK
	else:
		current_player.current_mode = Player.MODE.SHOOT_TP

func _on_level_round_start():
	await display_message("Round #" + str(TurnManager.round))

func _on_level_game_end():
	if GLOBAL.p1_points == GLOBAL.p2_points:
		display_message("Draw!!")
	if GLOBAL.p1_points > GLOBAL.p2_points:
		display_message("And the winner is... " + GLOBAL.p1_name + "!!")
	elif GLOBAL.p2_points > GLOBAL.p1_points:
		display_message("And the winner is... " + GLOBAL.p2_name + "!!")
	
	await get_tree().create_timer(3.0).timeout
	get_tree().call_deferred("change_scene_to_file", "res://scenes/hud/main_menu.tscn")
	

func _on_wind_bar_value_changed(value):
	#print_debug("VIENTO FRESCO: ", wind.wind_intensity)
	value = wind.wind_intensity

func _on_wind_area_new_wind(wind):
	%WindBar.value = wind
	if wind > 0:
		$CanvasLayer/WindPollo/GridContainer/TextureRect.flip_h = false
		$CanvasLayer/WindPollo/GridContainer/TextureRect2.flip_h = false
	else:
		$CanvasLayer/WindPollo/GridContainer/TextureRect.flip_h = true
		$CanvasLayer/WindPollo/GridContainer/TextureRect2.flip_h = true

func _on_level_turn_start(player):
	wind.change_wind()
	#print_debug(player, " cringe")
	
	display_message(str(player.p_name) + "'s turn!")
	#player.my_turn(true)
	current_player = player
	#current_player.p_name = player
	current_player.my_turn(true)
	can_shoot = true
	#print(player)

func apply_settings(previous_temp):
	power_input.text = previous_temp["power"]
	%CheckButton.button_pressed = previous_temp["mode"]
	%AngleEdit.text = previous_temp["angle"]

func set_previous_settings():
	previous_settings = {
	"power": power_input.text,
	"mode": %CheckButton.button_pressed,
	"angle": %AngleEdit.text
}

func angle_check():
	var rotation = float(%AngleEdit.text)
	if rotation <= 0: %AngleEdit.text = str(0)
	if rotation >= 180: %AngleEdit.text = str(179)
	print(float(%AngleEdit.text))

func _on_player_1_change_points():
	%P1PointsLabel.text = str(GLOBAL.p1_points)
	%P2PointsLabel.text = str(GLOBAL.p2_points)
	
func _on_player_2_change_points():
	%P1PointsLabel.text = str(GLOBAL.p1_points)
	%P2PointsLabel.text = str(GLOBAL.p2_points)
