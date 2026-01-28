
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
	var ray = $RayCast2D
	ray.enabled = true
	if body is TileMapLayer:
		var collision_point = ray.get_collision_point() - (ray.get_collision_normal() * 5)
		var tilemap: TileMapLayer = body
		var local_pos = tilemap.to_local(collision_point)
		var tile_pos = tilemap.local_to_map(local_pos)
		print("Body entered tile: ", tile_pos)
		print("body name : ", body.name)
		var tiledata = tilemap.get_cell_tile_data(tile_pos)
		print("tile health before hit : ",tiledata.get_custom_data("health") )
		var tilehealth = tiledata.get_custom_data("health")
		if tilehealth > 0:
			tiledata.set_custom_data("health",tilehealth - 1)
			print("tile health after hit : ",tiledata.get_custom_data("health") )
		else:
			print("Destroy tile")
			#tilemap.erase_cell(tile_pos)
		#print(cell_data.get_custom_data("health"))
