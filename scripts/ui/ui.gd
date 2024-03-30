extends Control

# TODO: Centrar texto del nodo Edit
# TODO: Capturar pantalla al momento de disparar y al momento de impacto con get_viewport().queue_screen_capture()

var deactivate_controls: bool = false

@onready var level_data = get_parent().get_parent().get_node("Level")
#@onready var player_data

func _ready():
	# TODO: Cargar puntuación de jugador 1 y 2
	# TODO: Cargar valores fuerza y ángulo de jugador 1 y 2
	# TODO: Cargar puntuación de jugador 1 y 2
	# TODO: 	Animación de ronda
	# TODO: botones
	# TODO: Quitar/Brindar acceso a controles
	# TODO: Cargar Nombres
	%P1Name.text = GLOBAL.p1_name
	%P2Name.text = GLOBAL.p2_name
	#get_tree().call_group("Button", "set_disabled", true)
	#get_tree().call_group("Edit", "set_editable", not true)
	
	pass

func _process(delta):
	pass

func _on_button_pressed():
	# TODO: fire_button debe chequear que esté todo en orden
	print_debug("fire_button")
	# TODO: Emite una señal al jugador correspondiente

func _on_give_up_button_pressed():
	print_debug("game_over")

''' ANGLE BUTTONS '''
func _on_angle_less_button_pressed():
	print_debug("increase_angle")
func _on_angle_more_button_pressed():
	print_debug("decrease_angle")

''' POWER BUTTONS '''
func _on_power_less_button_pressed():
	print_debug("increase_power")
func _on_power_more_button_pressed():
	print_debug("decrease_power")
