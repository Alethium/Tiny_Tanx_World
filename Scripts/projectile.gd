
class_name Projectile
extends Area2D  

@export var proj_name :String
@export var speed : float
@export var damage : float
@export var heat : float
@export var impact_effect : PackedScene
@onready var sprite: Sprite2D = $sprite
var projectile_owner = Player
var sprite_index = 0
var direction : Vector2
@onready var ray: RayCast2D = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _physics_process(delta):
	handle_animation()
	
	






func handle_animation():
	sprite_index += 0.1
	if sprite_index > 3:
		sprite_index = 0
	sprite.frame = sprite_index
func move(delta):
	global_position += direction * speed * delta	

func _on_body_entered(body: Node2D) -> void:
	
	ray.enabled = true
	if body is TileMapLayer:
		var collision_point = ray.get_collision_point() - (ray.get_collision_normal() * 5)
		var tilemap: TileMapLayer = body
		var local_pos = tilemap.to_local(collision_point)
		print("global position   : ", ray.get_collision_point())
		var tile_pos = tilemap.local_to_map(local_pos)
		print("tile_pos   : ", tilemap.local_to_map(local_pos))
		
		var tile_dict = get_parent().get_parent().get_parent().get_parent().level.tile_dict
		
		for i in range(0,tile_dict.size()):
			var tile_health = tile_dict[i][1]
			if tile_dict[i][0] == tile_pos  :
				tile_health -= damage * 0.5
				tile_health = clampf(tile_health,0.0,10.0)
				if abs(tile_health - round(tile_health)) < 0.001:
					damage_tile(body, tile_pos)
							


#				 set tile at this posiion to atlas spot -1
				print("tile index : ", i)
				print("at  :", tile_pos)
				tile_dict[i][1] = tile_health
				print("tile health  : ",tile_dict[i][1])
			#elif tile_dict[i][0] == tile_pos and tile_dict[i][1] == 0 :
				#print("tile destroyed")
				
		#print("Body entered tile: ", tile_pos)
		#print("body name : ", body.name)
		#var tiledata = tilemap.get_cell_tile_data(tile_pos)
		#print("tile health before hit : ",tiledata.get_custom_data("health") )
		#var tilehealth = tiledata.get_custom_data("health")
		#if tilehealth > 0:
			#tiledata.set_custom_data("health",tilehealth - 1)
			#print("tile health after hit : ",tiledata.get_custom_data("health") )
		#else:
			#print("Destroy tile")
			#tilemap.erase_cell(tile_pos)
		#print(cell_data.get_custom_data("health"))
func damage_tile(body,tile_pos):
	var old_atlas = body.get_cell_atlas_coords(tile_pos)
	var new_atlas = Vector2(old_atlas.x-1,old_atlas.y)
	var nearby_tiles = body.get_surrounding_cells(tile_pos)
	for tile in nearby_tiles:
		var old_nearby_atlas = body.get_cell_atlas_coords(tile)
		var new_nearby_atlas = Vector2(old_nearby_atlas.x-0.5,old_nearby_atlas.y)
		body.set_cell(tile,body.get_cell_source_id(tile),new_nearby_atlas,0)
	body.set_cell(tile_pos,body.get_cell_source_id(tile_pos),new_atlas,0)
