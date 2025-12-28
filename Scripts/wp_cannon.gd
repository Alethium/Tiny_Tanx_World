class_name Cannon
extends Weapon

const CANNON_LG = preload("uid://b1ho04fxtvp8l")


# Called when the node enters the scene tree for the first time.

	



func fire(dir :float):
	if !destroyed:
		print(cooldown_timer)
		var adjusted_angle = dir + deg_to_rad(90 + randf_range(-spread,spread))  # Assuming bottom_dir is in radians
		var move_direction = Vector2(cos(adjusted_angle), sin(adjusted_angle))
		if cooldown_timer == 0:
			gun_owner.overheat += heat
			cooldown_timer += cooldown
			var new_shot = munition.instantiate()
			new_shot.global_rotation = dir 
			new_shot.global_position = global_position
			new_shot.damage = damage
			new_shot.speed = speed
			new_shot.direction = -move_direction
			new_shot.projectile_owner = gun_owner
			get_parent().get_parent().get_parent().get_parent().get_parent().add_child(new_shot)
