extends KinematicBody2D


var velocity=Vector2()

func _physics_process(delta):
	for index in get_slide_count():
		var collision=get_slide_collision(index)
		if collision.collider.is_in_group("Egg"):
			print("hello")
			collision.collider.apply_central_impulse(-collision.normal*100)
	position=get_global_mouse_position()
	move_and_slide(velocity,Vector2.UP,false,4,PI/4,false)
