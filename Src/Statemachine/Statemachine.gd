extends Node


var states={}

var previous_state

var current_state

func _physics_process(delta):
	state_logic(delta)
	var state=tranisition(delta)
	if state!=null:
		previous_state=current_state
		current_state=state
		if previous_state!=null:
			enter_state(previous_state,current_state)
		if current_state!=null:
			exit_state(current_state,previous_state)


func state_logic(delta)->void:
	pass

func tranisition(delta):
	return null

func enter_state(old_state,new_state):
	pass
func exit_state(new_state,old_state):
	pass
