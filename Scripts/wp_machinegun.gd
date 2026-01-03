class_name MachineGun
extends Weapon

var jammed = false
var jam_timer := 0.0
var jam_length := 240.0
const BULLET_HIT = preload("uid://chp6dfk6nfk0e")

var has_overheat = true
var overheat := 0.0
var cooling := 0.1
var max_overheat := 100

# Called when the node enters the scene tree for the first time.

	
func _process(delta: float) -> void:
	super._process(delta)
	if overheat > 0:
		overheat -= cooling
	overheat = clampf(overheat,0,max_overheat)
	if jam_timer > 0 and jammed:
		jam_timer -= 1.0
		
	if overheat > max_overheat and !jammed:
		jammed = true
	
	if jam_timer <= 0 and jammed:
		jammed = false	




func fire(dir :float):
	if !destroyed and !jammed:
		print("overheat / max overheat", overheat, "  :  ", max_overheat)
		var adjusted_angle = dir + deg_to_rad(90 + randf_range(-spread,spread))  # Assuming bottom_dir is in radians
		var move_direction = Vector2(cos(adjusted_angle), sin(adjusted_angle))
		#if cooldown_timer == :
			#$shell_eject.play()
		if cooldown_timer == 0:
			$AudioStreamPlayer.play()
			overheat += 1.0
			cooldown_timer += cooldown
			gun_owner.overheat += heat
			var new_shot = munition.instantiate()
			var spark = BULLET_HIT.instantiate()
			gun_owner.cam.shake(0.5,1)
			Input.start_joy_vibration(gun_owner.player_device,0.0,0.2,0.2)
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


func get_meter():
	return overheat/max_overheat
