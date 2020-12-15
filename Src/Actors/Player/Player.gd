extends Node2D

const Egg = preload("res://Src/Actors/Others/Egg.tscn")

var movements: Dictionary = {}
var rotate_direction: int = 0
var fired=false
var fire_velocity=Vector2()

onready var bar_animation: AnimationPlayer = get_node("Bar/Baranimation")
onready var player_sprite: Sprite = get_node("Sprite")
onready var bar_texture: TextureProgress = get_node("Bar/Bar")
onready var animation_player:AnimationPlayer=get_node("Sprite/Player_animation")
onready var player_hit_area:KinematicBody2D=get_node("HitArea/KinematicBody2D")
enum {up,down,stop}
var Bar_mode=up

var egg

func _ready() -> void:
	#egg = Egg.instance()
	#egg.global_position = global_position
	#get_tree().current_scene.call_deferred("add_child", egg)
	#bar_texture.visible = false
	pass
func apply_movment(times):
	movements = {
		'left':Input.is_action_pressed("ui_left"),
		'right':Input.is_action_pressed("ui_right")
	}
	
	rotate_direction = int(movements['left']) - int(movements['right'])
	rotation_degrees += rotate_direction*times
	rotation_degrees = clamp(rotation_degrees, -15, 15)
	if rotate_direction!=0:
		scale.x=2 if rotation_degrees>0 else -2

func baranimationplay():
	bar_animation.play("Upanddown")

func baranimationstop(param:bool):
	bar_animation.stop(param)

func shoot_egg():
	egg.shoot(rotation, bar_texture.value)

func hit_logic():
	for index in player_hit_area.get_slide_count():
		var collision=player_hit_area.get_slide_collision(index)
		if collision.collider.is_in_group("Egg"):
			print("hellosososo")
			collision.collider.apply_central_impulse(-collision.normal*100)
	player_hit_area.move_and_slide(fire_velocity,Vector2.UP,false,4,PI/4,false)




