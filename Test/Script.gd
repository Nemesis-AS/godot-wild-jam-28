extends KinematicBody2D

var velocity = Vector2.ZERO

func _physics_process(_delta):
	velocity = Vector2(300,100)
	var degree = (-3.14/2)
	velocity = move_and_slide(velocity.rotated(degree))
