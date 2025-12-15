
class_name Projectile
extends Area2D  

@export var proj_name :String
@export var speed : float
@export var damage : float
@export var heat : float
@export var impact_effect : PackedScene
@onready var sprite: Sprite2D = $sprite

var sprite_index = 0
var direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _physics_process(delta):
	handle_animation()
	
	position += direction * speed * delta

	if global_position.distance_to(get_parent().global_position) > 2000:
		queue_free()




func handle_animation():
	sprite_index += 0.1
	if sprite_index > 3:
		sprite_index = 0
	sprite.frame = sprite_index
func move(delta):
	global_position += direction * speed * delta	
	






#func _on_body_entered(body):
	#if body.has_method("take_damage"):
		#body.take_damage(damage)
		#queue_free()
