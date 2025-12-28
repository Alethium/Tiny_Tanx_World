extends Node2D
@onready var front_left: Sprite2D = $paper_target_front_tread_L
@onready var front_right: Sprite2D = $paper_target_front_tread_R
@onready var rear_left: Sprite2D = $paper_target_rear_tread_L
@onready var rear_right: Sprite2D = $paper_target_rear_tread_R
@onready var front_mid: Sprite2D = $paper_target_core_front
@onready var core_rear: Sprite2D = $paper_target_core_rear
@onready var core_l: Sprite2D = $paper_target_core_L
@onready var core_r: Sprite2D = $paper_target_core_R
@onready var cockpit: Sprite2D = $paper_target_cockpit
@onready var weapon_r1: Sprite2D = $paper_target_weapon_R1
@onready var weapon_r2: Sprite2D = $paper_target_weapon_R2
@onready var weapon_l1: Sprite2D = $paper_target_weapon_R3
@onready var weapon_l2: Sprite2D = $paper_target_weapon_R4
@onready var player_ui: Control = $"../.."

const UI_GLOW_COLORS_PALETTE = preload("uid://bo5yombeylwhr")




func update_display(player):
	var ui_colors = UI_GLOW_COLORS_PALETTE.colors
	var components = [
		front_left,
		front_right,
		rear_left,
		rear_right,
		front_mid,
		core_rear,
		core_r,
		core_l,
		cockpit,
		weapon_r1,
		weapon_r2,
		weapon_l1,
		weapon_l2
	]

	for i in range(0,13):
		if player.components[i].armor <= 0:
			components[i].modulate = Color(ui_colors[5][0],ui_colors[5][1],ui_colors[5][2])
		elif player.components[i].armor < player.components[i].starting_armor * 0.10:
			#print(player.name, "player components armor :::: ",player.components[i].armor)
			components[i].modulate = Color(ui_colors[4][0],ui_colors[4][1],ui_colors[4][2])
		elif player.components[i].armor < player.components[i].starting_armor * 0.25:
			#print(player.name, "player components armor :::: ",player.components[i].armor)
			components[i].modulate = Color(ui_colors[3][0],ui_colors[3][1],ui_colors[3][2])
		elif player.components[i].armor < player.components[i].starting_armor * 0.50:
			#print(player.name, "player components armor :::: ",player.components[i].armor)
			components[i].modulate = Color(ui_colors[2][0],ui_colors[2][1],ui_colors[2][2])
		elif player.components[i].armor < player.components[i].starting_armor * 0.75:
			#print(player.name, "player components armor :::: ",player.components[i].armor)
			components[i].modulate = Color(ui_colors[1][0],ui_colors[1][1],ui_colors[1][2])
		elif player.components[i].armor == player.components[i].starting_armor: 
			#print(player.name, "player components armor :::: ",player.components[i].armor)
			components[i].modulate = Color(ui_colors[0][0],ui_colors[0][1],ui_colors[0][2])
