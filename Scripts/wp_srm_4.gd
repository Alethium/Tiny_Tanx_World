class_name MissileLauncher
extends Weapon

@export var volly_num : int
@export var num_per_volley : int
var volly_timer = 0
var firing = false
var direction : float
# Called when the node enters the scene tree for the first time.

	
func _physics_process(_delta: float) -> void:
	volly_timer -= 1
	volly_timer = clampi(volly_timer,0,100)
		
	
	if firing == true:
		fire_volleys()
	


func fire(dir :float):
	if !destroyed:
		direction = dir
		

		
		if cooldown_timer == 0:
			
			cooldown_timer += cooldown
			volly_timer += 10
			firing = true
			direction = dir
			volly_num = 2
		#var new_shot2 = munition.instantiate()
		#new_shot2.global_rotation = dir 
		#new_shot2.global_position = to_global(Vector2(position.x-8,position.y))
		#new_shot2.damage = damage
		#new_shot2.speed = speed
		#new_shot2.direction = -move_direction
		#get_parent().get_parent().get_parent().get_parent().get_parent().spawned_projectiles.add_child(new_shot2)
func fire_volleys():
	if !destroyed:
		var adjusted_angle = direction + deg_to_rad(90 + randf_range(-spread,spread))  # Assuming bottom_dir is in radians
		var move_direction = Vector2(cos(adjusted_angle), sin(adjusted_angle))
		
		if volly_timer == 0 and volly_num > 0:
			
			volly_num -= 1
			volly_timer += 15
			for i in range(0,2):
				var new_shot = munition.instantiate()
				gun_owner.overheat += heat
				gun_owner.cam.shake(2,1)
				Input.start_joy_vibration(gun_owner.player_device,1.0,0.5,0.1)
				$AudioStreamPlayer.play()
				new_shot.global_rotation = direction
				new_shot.global_position = to_global(Vector2(position.x + ( 9 * i )-4,position.y))
				new_shot.projectile_owner = gun_owner
				new_shot.damage = damage
				new_shot.speed = speed
				
				new_shot.direction = -move_direction
				new_shot.projectile_owner = gun_owner
				get_parent().get_parent().get_parent().get_parent().get_parent().add_child(new_shot)
			
		if volly_num == 0:	
			firing = false
