extends Area2D

export(int) var SPEED = 150

var direction : Vector2

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta

