extends Node2D

const move_speed=250.0


var movements:Dictionary={}

var velocity_vector=Vector2()

onready var body=get_node("Body")

onready var hand=get_node("Body/Hand")

onready var player=get_node("Body/PlayerKinematic")

func apply_movement():
	movements={'Left':Input.is_action_just_pressed("ui_left"),
				'Right':Input.is_action_pressed("ui_right"),
				'Up':Input.is_action_pressed("ui_up"),
				'Down':Input.is_action_pressed("ui_down") }
	
