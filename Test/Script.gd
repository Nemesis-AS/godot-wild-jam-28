extends KinematicBody2D

var velocity=Vector2()

func _physics_process(delta):
	velocity=Vector2(300,100)
	var degree=(-3.14/2)
	move_and_slide(velocity.rotated(degree))
