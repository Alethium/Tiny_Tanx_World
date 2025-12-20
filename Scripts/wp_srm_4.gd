class_name MissileLauncher
extends Weapon

@export var volly_num : int
@export var num_per_volley : int
var volly_timer = 0


# Called when the node enters the scene tree for the first time.

	
func _physics_process(delta: float) -> void:
	volly_timer -= 1
	volly_timer = clampi(volly_timer,0,100)


func on_destroyed():
	pass


func fire(dir :float):
	
	var adjusted_angle = dir + deg_to_rad(90 + randf_range(-spread,spread))  # Assuming bottom_dir is in radians
	var move_direction = Vector2(cos(adjusted_angle), sin(adjusted_angle))
	
	if cooldown_timer == 0:
		
		cooldown_timer += cooldown
		gun_owner.overheat += heat
		
		for i in range(0,volly_num):
		
				for j in range(0,num_per_volley):
					var new_shot = munition.instantiate()
					new_shot.global_rotation = dir 
					new_shot.global_position = to_global(Vector2(position.x + ( 10*i ),position.y))
					new_shot.projectile_owner = gun_owner
					new_shot.damage = damage
					new_shot.speed = speed
					new_shot.direction = -move_direction
					new_shot.projectile_owner = gun_owner
					get_parent().get_parent().get_parent().get_parent().get_parent().add_child(new_shot)
		#var new_shot2 = munition.instantiate()
		#new_shot2.global_rotation = dir 
		#new_shot2.global_position = to_global(Vector2(position.x-8,position.y))
		#new_shot2.damage = damage
		#new_shot2.speed = speed
		#new_shot2.direction = -move_direction
		#get_parent().get_parent().get_parent().get_parent().get_parent().spawned_projectiles.add_child(new_shot2)
