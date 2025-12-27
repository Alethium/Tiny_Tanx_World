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


@onready var components = [
	front_left,
	front_right,
	rear_left,
	rear_right,
	front_mid,
	core_rear,
	core_l,
	core_r,
	cockpit,
	weapon_r1,
	weapon_r2,
	weapon_l1,
	weapon_l1
]
