extends Control

# TODO: Centrar texto del nodo Edit
# TODO: Capturar pantalla al momento de disparar y al momento de impacto con get_viewport().queue_screen_capture()
# TODO: Agregar limites para los lineedit

# FIXME: Oh, cáspita! Los grados se pasan, fijate que los grados no pasen del rango -195 al 18

signal give_up
signal change_mode
signal end_turn

@export var screen_message: PackedScene = preload("res://scenes/hud/screen_message.tscn")

var deactivate_controls: bool = false
var current_player: Player

@onready var level_data = get_parent().get_parent().get_node("Level")
@onready var player_data = get_parent().get_node("Players").get_children()
@onready var wind = get_parent().get_node("WindArea")

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
	#%P1Name.text = GLOBAL.p1_name
	#%P2Name.text = GLOBAL.p2_name
	#get_tree().call_group("Button", "set_disabled", true)
	#get_tree().call_group("Edit", "set_editable", not true)
	
	''' Mensaje inicial '''
	#await display_message("Begin!")
	
func display_message(text: String):
	var message = screen_message.instantiate()
	message.message_text = str(text)
	add_child(message)

func _process(delta):
	# TODO: Quiero que todos los botones se muestren presionados cuando se realiza un input del teclado (jugo)
	if Input.is_action_just_pressed("fire"):
		# TODO: desactivar boton hasta siguiente ronda
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
	# TODO: fire_button debe chequear que esté todo en orden
	
	#current_player.my_turn(true)
	#print_debug("fire_button")
	_on_check_button_toggled(%CheckButton.button_pressed)
	change_power()
	current_player.attack()
	var previous_temp = previous_settings
	set_previous_settings()
	emit_signal("end_turn")
	apply_settings(previous_temp)
	# TODO: Emite una señal al jugador correspondiente

func _on_give_up_button_pressed():
	display_message("You gave up! Now your oponent is the king!")
	emit_signal("give_up")
	
''' ANGLE BUTTONS '''
func _on_angle_less_button_pressed():
	#print_debug("increase_angle")
	current_player.rot -= 5
	%AngleEdit.text = str(current_player.cannon.global_rotation_degrees)
func _on_angle_more_button_pressed():
	#print_debug("decrease_angle")
	current_player.rot += 5
	%AngleEdit.text = str(current_player.cannon.global_rotation_degrees)#str(current_player.rot)
func _on_angle_edit_text_changed(new_text):
	current_player.rot = float(new_text)
	%AngleEdit.text = str(float(new_text))

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
	print("pinga")

func _on_level_game_end():
	var winner: String = "john"
	display_message("El ganador es: " + winner + "!!")

func _on_wind_bar_value_changed(value):
	print_debug("VIENTO FRESCO: ", wind.wind_intensity)
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
	#print_debug(player, " cringe")
	
	display_message(str(player.name) + "'s turn!")
	#player.my_turn(true)
	current_player = player
	#current_player.name = player
	current_player.my_turn(true)
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
