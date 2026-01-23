class_name GarageMenu
extends Menu

enum MenuState {TITLE,START,GARAGE,SETTINGS,PAUSE,CLOSED}


@onready var l_1: Sprite2D = $Menu_container/Builder_ui/Button1/L1_Selection
@onready var l_2: Sprite2D = $Menu_container/Builder_ui/Button2/L2_Selection
@onready var r_2: Sprite2D = $Menu_container/Builder_ui/Button3/R2_Selection
@onready var r_1: Sprite2D = $Menu_container/Builder_ui/Button4/R1_Selection

var active_button_index = 0
var active_button_weapon_index = 0
@onready var tank_blueprint: Sprite2D = $Menu_container/Panel/TankBlueprint_view
@onready var weapon_selection: Sprite2D = $Menu_container/Panel/Weapon_selection
@onready var weapon_blueprint: Sprite2D = $Menu_container/Panel/LargeWeaponBlueprint

const WP_CANNON = preload("uid://8qrv1ct2axpq")
const WP_LASER = preload("uid://dgxw3ow82ruaw")
const WP_MACHINEGUN = preload("uid://dx11aqaggxpxn")
const WP_SRM_4 = preload("uid://ydce2xf53jyc")
@onready var equippable_weapons = [
	WP_LASER,
	WP_MACHINEGUN,
	WP_CANNON,
	WP_SRM_4
]
@onready var Weapon_text_array = [
	["Medium Laser"," Highly Focused Beam \n High Damage \n Over Time"],
	["MachineGun","High Rate of Fire \n Can Overheat \n And Break"],
	["AutoCannon", "Low Rate of Fire \n Very High \n Damage"],
	["Short Range Missile", " 2x2 Heat \n Seeking Missiles \n Can Go Over \n Terrain"]
	
]
@onready var selected_weapons_array = [
	[l_1, 0,equippable_weapons[0]],  # Pair 1
	[l_2, 0,equippable_weapons[0]],  # Pair 2  
	[r_2, 0,equippable_weapons[0]],  # Pair 3
	[r_1, 0,equippable_weapons[0]]       # Single element
]


#TODO add text in. 



func _process(_delta: float) -> void:
	if !active:
		visible = false
		
	elif active:
		visible = true
		if Input.is_action_just_pressed(Controls.UI_right):
			print("player pressing UI button right : ", active_button_index)
			if active_button_index < 3:
				active_button_index += 1
			else:
				active_button_index = 0
		if Input.is_action_just_pressed(Controls.UI_left):
			
			print("player pressing UI button left : ",active_button_index)
			if active_button_index > 0:
				active_button_index -= 1
			else:
				active_button_index = 3
				
		if Input.is_action_just_pressed(Controls.UI_up):
			print("player pressing UI button right : ", active_button_index)
			if selected_weapons_array[active_button_index][1] < 3:
				selected_weapons_array[active_button_index][1] += 1
				selected_weapons_array[active_button_index][2] = equippable_weapons[selected_weapons_array[active_button_index][1]]
			else:
				selected_weapons_array[active_button_index][1] = 0
				selected_weapons_array[active_button_index][2] = equippable_weapons[selected_weapons_array[active_button_index][1]]
			print("selected weapon index : ", selected_weapons_array[active_button_index][1])
		if Input.is_action_just_pressed(Controls.UI_down):
			
			print("player pressing UI button left : ",active_button_index)
			if selected_weapons_array[active_button_index][1] > 0:
				selected_weapons_array[active_button_index][1] -= 1
				selected_weapons_array[active_button_index][2] = equippable_weapons[selected_weapons_array[active_button_index][1]]
			else:
				selected_weapons_array[active_button_index][1] = 3
				selected_weapons_array[active_button_index][2] = equippable_weapons[selected_weapons_array[active_button_index][1]]
			print("selected weapon index : ", selected_weapons_array[active_button_index][1])
		weapon_selection.frame = active_button_index
		tank_blueprint.frame = active_button_index
		selected_weapons_array[active_button_index][0].frame = selected_weapons_array[active_button_index][1]
		weapon_blueprint.frame = selected_weapons_array[active_button_index][1]
		$Menu_container/Panel/Text_Display/weapon_name.text = Weapon_text_array[selected_weapons_array[active_button_index][1]][0]
		$Menu_container/Panel/Text_Display/weapon_description.text = Weapon_text_array[selected_weapons_array[active_button_index][1]][1]
		print("the currently displayed weapon index is :", selected_weapons_array[active_button_index][1])
		
	
		if Input.is_action_just_pressed(Controls.UI_back):
			print("player pressing UI button back")
			get_parent().start_menu.process_mode = Node.PROCESS_MODE_ALWAYS
			get_parent().set_state(MenuState.START)
