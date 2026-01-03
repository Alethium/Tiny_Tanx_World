class_name EnemyRadar
extends Node2D
@export var tracked_enemies = []
@onready var top_view: Sprite2D = $Top_view
@onready var bottom_direction: Sprite2D = $Bottom_direction
@onready var radar_screen: Sprite2D = $Radar_screen
@onready var radar_dot: Sprite2D = $"Radar dot"



func display_tracked_enemies(dir,dist):
	if tracked_enemies.size() != 0:
		radar_dot.rotation_degrees = dir - 90
		
		radar_dot.offset.y = dist/30
		radar_dot.offset.y = clamp(radar_dot.offset.y,0,19.5)
#		add a radar dot. 
# track distance to player and direction. 
# scale the distance down to cover whats in an on screen kind of distance from the player, and put the dot on the edge of the ring. 
# likely need circle math to just have a distance
