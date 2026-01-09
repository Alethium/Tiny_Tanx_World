class_name ButtonExample
extends Node2D


@onready var owner_index :int

@onready var key1: Sprite2D = $keyboard_icon
@onready var xbox1: Sprite2D = $xbox_icon
@onready var play1: Sprite2D = $playstation_icon
@onready var switch1: Sprite2D = $switch_icon
@onready var key2: Sprite2D = $keyboard_icon2
@onready var xbox2: Sprite2D = $xbox_icon_p2
@onready var play2: Sprite2D = $playstation_icon_p2
@onready var switch2: Sprite2D = $switch_icon_p2
@onready var timer: Timer = $Timer

var cycle_index = 0



func _process(delta: float) -> void:
		#print("this owner index is 1")
		if owner_index == 1:
			key2.visible = key1.visible
			xbox2.visible = xbox1.visible
			play2.visible = play1.visible
				
	
		
		

func cycle_controls():
	print("cycling button : ", cycle_index)
	if cycle_index < 2:
		cycle_index += 1
	else:
		cycle_index = 0
	#print("cycle index : ", cycle_index)
	
	if cycle_index == 0:
		play1.visible = false
		key1.visible = true
	if cycle_index == 1:
		key1.visible = false
		xbox1.visible = true
	if cycle_index == 2:
		xbox1.visible = false
		play1.visible = true
	
	


#TODO figure out how to tell what kind of controller player one and two are using
# and then display the right button type
# maybe just rotate through the button types and and not give tooo much a shit
