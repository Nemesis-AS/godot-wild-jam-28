extends 'res://Src/Statemachine/Statemachine.gd'



class Fire_statge:
	enum {
		short,
		long,
		overpowered
	}
	var mode=short

func _init():
	states={
		1:"Idle",
		"Run":{
			1:"left",
			2:"right",
			3:"up",
			4:"down"
		},
		"Fire":{
			"Directions":{
			1:"left",
			2:"right",
			3:"up",
			4:"down"
			}
		}
	}
 
