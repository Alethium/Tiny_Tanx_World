class_name Vfx
extends Node2D 

@export var vfx_name :String
@export var anim_speed : float
@export var frame_count : int
@onready var sprite: Sprite2D = $"Vx sprite"
@export var looping = false




var sprite_index = 0
var hit_rotation = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _physics_process(delta):
	handle_animation()
	
	






func handle_animation():
	if frame_count != null:
		sprite_index += anim_speed/10
		if sprite_index > frame_count:
			if looping == true:
				sprite_index = 0
		sprite.frame = sprite_index
		
