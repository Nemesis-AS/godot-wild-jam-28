extends Node2D

const Egg = preload("res://Src/Actors/Others/Egg.tscn")

var movements: Dictionary = {}
var rotate_direction: int = 0

onready var bar_animation: AnimationPlayer = get_node("Bar/Baranimation")
onready var player_sprite: Sprite = get_node("Sprite")
onready var bar_texture: TextureProgress = get_node("Bar/Bar")

enum {up,down,stop}
var Bar_mode=up

var egg

func _ready() -> void:
	egg = Egg.instance()
	egg.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", egg)
	
	bar_texture.visible = false

func apply_movment(times):
	movements = {
		'left':Input.is_action_pressed("ui_left"),
		'right':Input.is_action_pressed("ui_right")
	}
	
	rotate_direction = int(movements['left']) - int(movements['right'])
	rotation_degrees += rotate_direction*times
	rotation_degrees = clamp(rotation_degrees, -60, 60)

func baranimationplay():
	bar_animation.play("Upanddown")

func baranimationstop(param:bool):
	bar_animation.stop(param)

func shoot_egg():
	egg.shoot(rotation, bar_texture.value)


