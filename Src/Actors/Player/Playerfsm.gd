extends 'res://Src/Statemachine/Statemachine.gd'

class Fire:
	var shooting:bool= false
	var firing:bool=false
	var bar_value:float=0.0
class moving:
	var moving=false

onready var fire_state= Fire.new()
onready var moving_state = moving.new()

func _init():
	states={
		1: "Idle",
		2: "Turn",
		"Shoot": {
			1: "ShootIdle",
			2: "Fire",
			3: "ShootTurn"
		},
	}

func _ready():
	current_state = states[1]


func state_logic(delta):
	var times = 1 if !fire_state.shooting else 0.25
	parent.apply_movment(times)

func tranisition(delta):
	match current_state:
		"Idle":
			if parent.rotate_direction!=0:
				return states[2]
			if fire_state.shooting:
				return states["Shoot"][1]
		"Turn":
			if parent.rotate_direction==0:
				return states[1]
		"ShootIdle":
			if fire_state.firing:
				return states["Shoot"][2]
			if !fire_state.shooting:
				return states[1]
		"Fire":
			if !fire_state.firing:
				return states[1]
		"ShootTrun":
			if parent.rotate_direction==0:
				return states["Shoot"][1]
			if ! fire_state.shooting:
				return states[1]
	return null

func enter_state(old_state,new_state):
	match new_state:
		"Idle":
			pass
		"ShootIdle":
			on_entering_shoot_idle()
		"Fire":
			on_entering_fire_state()
	if new_state in ["Idle","Fire"]:
		parent.animation_player.play(new_state)

func exit_state(new_state,old_state):
	match old_state:
		"ShootIdle":
			on_exiting_shoot_idle(new_state)
		"Fire":
			pass
func _unhandled_input(event):
	if current_state in ["Idle","ShootIdle"]:
		if event.is_action_pressed("Space"):
			fire_state.shooting= not fire_state.shooting
		if event.is_action_pressed("Click")&&fire_state.shooting:
			fire_state.firing=true


func _on_Baranimation_animation_finished(anim_name):
	if current_state in ["ShootIdle"]:
		if parent.bar_texture.value==100:
			parent.bar_animation.play_backwards("Upanddown")
		else:
			parent.bar_animation.play("Upanddown")
	else:
		parent.bar_animation.stop()

func on_entering_shoot_idle():
	parent.bar_texture.visible=true
	parent.baranimationplay()

func on_exiting_shoot_idle(new_state):
	if new_state =="Fire":
		parent.baranimationstop(false)
	else:
		parent.bar_texture.visible=false
		parent.baranimationstop(true)
		parent.bar_texture.value=0

func on_entering_fire_state():
	#it sould animate
	#getcolliderinfo and apply impulse
	print("Hi")


func _on_Player_animation_animation_finished(anim_name):
	match anim_name:
		"Fire":
			fire_state.firing=false
			fire_state.shooting=false
			parent.bar_texture.visible=false
