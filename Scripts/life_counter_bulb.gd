class_name LifeBulb
extends Sprite2D



@onready var bulb_on = true




func toggle_light():
	
	if bulb_on == true:
		bulb_on = false
		print("bulb toggled to",bulb_on)
		frame = 0
	else:
		bulb_on = true
		print("bulb toggled to",bulb_on)
		frame = 1
