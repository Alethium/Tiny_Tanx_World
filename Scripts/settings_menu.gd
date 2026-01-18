class_name SettingsMenu
extends Menu

enum MenuState {TITLE,START,GARAGE,SETTINGS,PAUSE,CLOSED}

var active_button_index = 0



func _process(delta: float) -> void:
	if !active:
		visible = false
		
	elif active:
		visible = true
		#graphics
#		fullscreen/windowed
#		
#--------------------AUDIO----------------------

#		master volume
#		sfx
#		music

#
#		
#		
#		
#		
#		
#		
#		
		
		if Input.is_action_just_pressed(Controls.UI_back):
			print("player pressing UI button back")
			get_parent().start_menu.process_mode = Node.PROCESS_MODE_ALWAYS
			get_parent().set_state(MenuState.START)
