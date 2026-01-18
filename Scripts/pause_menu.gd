class_name PauseMenu
extends Menu

enum MenuState {TITLE,START,GARAGE,SETTINGS,PAUSE,CLOSED}

var active_button_index = 0



func _process(delta: float) -> void:
	if !active:
		visible = false
		
	elif active:
		visible = true
		#if Input.is_action_just_pressed(Controls.UI_right):
			#print("player pressing UI button right : ", active_button_index)
			#if active_button_index < 3:
				#active_button_index += 1
			#else:
				#active_button_index = 0
		#if Input.is_action_just_pressed(Controls.UI_left):
			#
			#print("player pressing UI button left : ",active_button_index)
			#if active_button_index > 0:
				#active_button_index -= 1
			#else:
				#active_button_index = 3
	#weapon_selection.frame = active_button_index
	#tank_blueprint.frame = active_button_index
