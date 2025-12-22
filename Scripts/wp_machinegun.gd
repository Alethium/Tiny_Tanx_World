class_name MachineGun
extends Weapon


const BULLET_HIT = preload("uid://chp6dfk6nfk0e")



# Called when the node enters the scene tree for the first time.

	



func on_destroyed():
	pass


func fire(dir :float):
	
	var adjusted_angle = dir + deg_to_rad(90 + randf_range(-spread,spread))  # Assuming bottom_dir is in radians
	var move_direction = Vector2(cos(adjusted_angle), sin(adjusted_angle))
	
	if cooldown_timer == 0:
		cooldown_timer += cooldown
		gun_owner.overheat += heat
		var new_shot = munition.instantiate()
		var spark = BULLET_HIT.instantiate()
		
		spark.global_rotation = dir+deg_to_rad(-180)
		spark.global_position = global_position
		
		new_shot.global_rotation = dir 
		new_shot.global_position = global_position
		new_shot.damage = damage
		new_shot.speed = speed
		new_shot.direction = -move_direction
		new_shot.projectile_owner = gun_owner
		get_parent().get_parent().get_parent().get_parent().get_parent().add_child(new_shot)
		get_parent().get_parent().get_parent().get_parent().get_parent().add_child(spark)
		#var new_shot2 = munition.instantiate()
		#new_shot2.global_rotation = dir 
		#new_shot2.global_position = to_global(Vector2(position.x-8,position.y))
		#new_shot2.damage = damage
		#new_shot2.speed = speed
		#new_shot2.direction = -move_direction
		#get_parent().get_parent().get_parent().get_parent().get_parent().spawned_projectiles.add_child(new_shot2)
