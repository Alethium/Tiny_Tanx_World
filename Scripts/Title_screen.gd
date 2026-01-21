class_name TitleScreen
extends Menu
enum MenuState {TITLE,START,GARAGE,SETTINGS,PAUSE,CLOSED}

@onready var accept_example: AcceptButtonExample = $"Accept Button_example_icon"


func _process(delta: float) -> void:
	if !active:
		visible = false
		process_mode = Node.PROCESS_MODE_DISABLED
	elif active:
		process_mode = Node.PROCESS_MODE_ALWAYS
		if owner_index == 1:
			accept_example.owner_index = 1

		
		if Input.is_action_just_pressed(Controls.UI_accept):
			print("player pressing UI button accept")
			get_parent().menu_state = MenuState.START
			print("player_ui menu state",get_parent().menu_state)
			active = false
#		THIS IS WHERE I NEED TO CAPTURE WHAT DEVICE A PLAYER WANTS TO USE
#> 		IF CONTROLLER PRESS A THEN THEY GO ON THE LEFT
#> 		IF THEY PRESS X THEY GO ON THE RIGHTT
#		
