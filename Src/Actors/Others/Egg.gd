extends KinematicBody2D

export(int) var SPEED = 100
export(bool) var physics_enabled = true

const Bullet = preload("res://Src/Actors/Others/EggBullet.tscn")

var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var bulletSpawnPosition = $Sprite/BulletSpawnPosition

func _ready() -> void:
	set_physics_process(physics_enabled)

func _physics_process(_delta: float) -> void:
	var input_vector = Vector2(0, -1)
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector = input_vector.normalized()
	
	velocity = input_vector * SPEED
	velocity = move_and_slide(velocity, Vector2.UP)
	
	sprite.rotation = get_angle_to(get_global_mouse_position()) + deg2rad(90)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.is_pressed():
		var bullet = Bullet.instance()
		bullet.global_position = bulletSpawnPosition.global_position
		bullet.direction = (get_global_mouse_position() - bulletSpawnPosition.global_position).normalized()
		get_tree().current_scene.call_deferred("add_child", bullet)
