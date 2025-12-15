class_name MachineGun
extends Weapon




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	






func fire(dir :float):
	print(cooldown_timer)
	var adjusted_angle = dir + deg_to_rad(90 + randf_range(-spread,spread))  # Assuming bottom_dir is in radians
	var move_direction = Vector2(cos(adjusted_angle), sin(adjusted_angle))
	
	if cooldown_timer == 0:
		cooldown_timer += cooldown
		var new_shot = munition.instantiate()
		new_shot.global_rotation = dir 
		new_shot.global_position = global_position
		new_shot.damage = damage
		new_shot.speed = speed
		new_shot.direction = -move_direction
		get_parent().get_parent().get_parent().get_parent().get_parent().spawned_projectiles.add_child(new_shot)
		#var new_shot2 = munition.instantiate()
		#new_shot2.global_rotation = dir 
		#new_shot2.global_position = to_global(Vector2(position.x-8,position.y))
		#new_shot2.damage = damage
		#new_shot2.speed = speed
		#new_shot2.direction = -move_direction
		#get_parent().get_parent().get_parent().get_parent().get_parent().spawned_projectiles.add_child(new_shot2)
