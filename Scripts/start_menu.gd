class_name StartMenu
extends Menu
enum MenuState {TITLE,START,GARAGE,SETTINGS,PAUSE,CLOSED}

var highlighted_button_index = 0
@onready var begin: Panel = $Control/VBoxContainer/Begin_button
@onready var garage: Panel = $Control/VBoxContainer/Garage_button
@onready var settings: Panel = $Control/VBoxContainer/Settings_button
@onready var exit: Panel = $Control/VBoxContainer/Exit_button

var active_button_index = 0


func _process(delta: float) -> void:
	print("start menu active : ",active)
	if !active:
		visible = false

	if active:
		if Input.is_action_just_pressed(Controls.UI_down):
			print("player pressing UI button down : ", active_button_index)
			if active_button_index < 3:
				active_button_index += 1
			else:
				active_button_index = 0
		if Input.is_action_just_pressed(Controls.UI_up):
			
			print("player pressing UI button up : ",active_button_index)
			if active_button_index > 0:
				active_button_index -= 1
			else:
				active_button_index = 3
		
		if active_button_index == 0:
			begin.modulate = Color.GREEN
			garage.modulate = Color.RED
			settings.modulate = Color.RED
			exit.modulate = Color.RED
		elif active_button_index == 1:
			begin.modulate = Color.RED
			garage.modulate = Color.GREEN
			settings.modulate = Color.RED
			exit.modulate = Color.RED
		elif active_button_index == 2:
			begin.modulate = Color.RED
			garage.modulate = Color.RED
			settings.modulate = Color.GREEN
			exit.modulate = Color.RED
		elif active_button_index == 3:
			begin.modulate = Color.RED
			garage.modulate = Color.RED
			settings.modulate = Color.RED
			exit.modulate = Color.GREEN
			

		
		
		
		if Input.is_action_just_pressed(Controls.UI_accept):
			if active_button_index == 0:
				print("player pressing UI button accept on begin")
				process_mode = Node.PROCESS_MODE_DISABLED
				get_parent().menu_state = MenuState.CLOSED
				get_parent().get_parent().spawn_in()
				active = false
				visible = false
