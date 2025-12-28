class_name ShortRangeMissile
extends Projectile  

 #TODO 
#MAKE the fucking rocket have a direction ya, then make it turn toward that direction right?,
 #then ya wanna have that turn speed dialed, give it a target and itll follow em, ya got it ?
# Called when the node enters the scene tree for the first time.
#g


var target : Player
var impacted = false
@export var turn_speed = 10
@export var life : float
# Called when the node enters the scene tree for the first time.

	

#
#
func _physics_process(delta):
	life -= 1
	if life <= 0:
		_on_airburst()
	handle_tracking(delta)
	move(delta)



func handle_tracking(delta):
	if target:
		# Calculate direction to target
		var target_direction = (target.global_position - global_position).normalized()
		
		# Smooth rotation by interpolating
		direction = direction.lerp(target_direction, turn_speed * delta).normalized()
		
		# Set rotation to face the movement direction
		# In Godot, -Y is forward, so we use atan2 on the reversed vector
		global_rotation = atan2(direction.y, direction.x) + PI/2


#func handle_animation():
	#sprite_index += 0.1
	#if sprite_index > 3:
		#sprite_index = 0
	#sprite.frame = sprite_index
func move(delta):
	if !impacted:
		global_position += direction * speed * delta	
	


func impact():
	impacted = true
	sprite.visible = false

	queue_free()

func _on_airburst():
	if impacted == false:
		var hitspark = impact_effect.instantiate()
		hitspark.global_position = sprite.global_transform.origin 
		hitspark.rotation = rotation
		get_parent().add_child(hitspark)
		impact()
	

func _on_impact(_area):
	if impacted == false:
		if _area.has_method("_on_damage_recieved") and _area.component_owner != projectile_owner:
			var hitspark = impact_effect.instantiate()
			hitspark.global_position = sprite.global_transform.origin 
			hitspark.rotation = rotation
			hitspark.damage = damage
			get_parent().add_child(hitspark)
			_area._on_damage_recieved(damage)
			impact()
	
	
#
#


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body != projectile_owner:
		print("player_targeted")
		target = body


func _on_area_2d_body_exited(_body: Node2D) -> void:
	print("target_lost")
	target = null
