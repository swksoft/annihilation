extends Control

# TODO: Centrar texto del nodo Edit
# TODO: Capturar pantalla al momento de disparar y al momento de impacto con get_viewport().queue_screen_capture()

# FIXME: Oh, cáspita! Los grados se pasan, fijate que los grados no pasen del rango -195 al 18

@export var screen_message: PackedScene = preload("res://scenes/hud/screen_message.tscn")

var deactivate_controls: bool = false
var current_player: Object

@onready var level_data = get_parent().get_parent().get_node("Level")
@onready var player_data = get_parent().get_node("Players").get_children()

func _ready():
	''' OBTENER ESCENA DE TODOS LOS PLAYERS '''
	current_player = player_data[0]  # TODO: esto debe cambiar
	%AngleEdit.text = str(current_player.rot)
	
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
	display_message()
	
func display_message():
	var message = screen_message.instantiate()
	message.message_text = "Begin!"
	add_child(message)

func _process(delta):
	# TODO: Quiero que todos los botones se muestren presionados cuando se realiza un input del teclado (jugo)
	if Input.is_action_just_pressed("fire"):
		# TODO: desactivar boton hasta siguiente ronda
		%Button.button_pressed = true
		_on_button_pressed()
	elif Input.is_action_just_pressed("give_up"): _on_give_up_button_pressed()
	elif Input.is_action_pressed("inc_angle"): _on_angle_less_button_pressed()
	elif Input.is_action_pressed("dec_angle"): _on_angle_more_button_pressed()
	elif Input.is_action_pressed("inc_power"): _on_power_less_button_pressed()
	elif Input.is_action_pressed("dec_power"): _on_power_more_button_pressed()

func _on_button_pressed():
	# TODO: fire_button debe chequear que esté todo en orden
	
	print_debug("fire_button")
	current_player.attack()
	
	# TODO: Emite una señal al jugador correspondiente

func _on_give_up_button_pressed():
	print_debug("game_over")

''' ANGLE BUTTONS '''
func _on_angle_less_button_pressed():
	#print_debug("increase_angle")
	current_player.rot -= 1
	%AngleEdit.text = str(current_player.rot)
func _on_angle_more_button_pressed():
	#print_debug("decrease_angle")
	current_player.rot += 1
	%AngleEdit.text = str(current_player.rot)

''' POWER BUTTONS '''
func _on_power_less_button_pressed():
	print_debug("increase_power")
func _on_power_more_button_pressed():
	print_debug("decrease_power")

''' SHOOT MODE '''
func _on_check_button_toggled(toggled_on):
	print("pico")

func _on_angle_edit_text_changed(new_text):
	#if new_text
	current_player.rot = int(new_text)
