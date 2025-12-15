class_name Target
extends Area2D
@onready var sprite: Sprite2D = $Sprite2D
@export var health = 30
var sprite_count = 4
var sprite_index = 0
var spin = 0
var respawn_timer = 0
var respawn_length = 120
const EXPLOSION_1 = preload("uid://cn25vrrfdwenv")
var exploded = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	respawn_timer = respawn_length


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	handle_animation()
	
	if health <= 0 :
		if exploded == false:
			explode()
			monitorable = false
			
		sprite.visible = false
		respawn_timer -= 1
		if respawn_timer <= 0:
			queue_free()
			respawn()
		
	
	



func respawn():
	respawn_timer = respawn_length
	health = 20
	sprite.visible = true
	spin = 0
	exploded = false



func handle_animation():
	if spin > 0 :
		spin -= 0.01
		sprite_index += spin
		if sprite_index > sprite_count-1:
			sprite_index = 0
		sprite.frame = sprite_index


func _on_area_entered(area: Area2D) -> void:
	if area is Projectile:
		on_damage_recieved(area.damage)

	
func explode():
	exploded = true
	var explosion = EXPLOSION_1.instantiate()
	#explosion.global_position = self.global_position
	add_child(explosion)
func on_damage_recieved(damage):
	health -= damage
	spin += 0.5 
	
