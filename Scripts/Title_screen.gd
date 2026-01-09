class_name TitleScreen
extends Menu
enum MenuState {TITLE,START,GARAGE,SETTINGS,PAUSE}

func _process(delta: float) -> void:
	visible = active
	
	
	
	if Input.is_action_just_pressed(Controls.UI_accept):
		print("player pressing UI button accept")
		get_parent().menu_state = 1
		print("player_ui menu state",get_parent().menu_state)
		active = false
