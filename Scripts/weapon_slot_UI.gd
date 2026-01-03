class_name WeaponSlotUI
extends Node2D

@onready var cooldown_bar: Control = $Weapon_cooldown_bar
@onready var weapon_disabled: Sprite2D = $Cooldown_disabled
@onready var weapon_destroyed: Sprite2D = $Weapon_disabled
@onready var weapon_sprite: Sprite2D = $Weapon_Icon/Weapon_sprite


func set_icon(weapon):
	weapon_sprite.frame = weapon.icon_index
	
