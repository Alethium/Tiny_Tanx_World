class_name Component
extends Area2D

@export var health : float
@export var armor : float
@export var paper_target : Sprite2D
@onready var starting_health = health
@onready var starting_armor = armor
@export var component_owner : Player
var destroyed = false

const EXPLOSION_COMPONENT = preload("uid://t148unhpctq0")


		
func _on_ghost_damage_recieved(damage:float):
	if armor > 0:
		armor -= damage/2
		print("damage : ",damage, "component ghost damaged : " , self.name,"component health and armor : ", health, " / ",armor)
	elif health > 0:
		health -= damage
		print("damage : ",damage, "component ghost damaged : " , self.name,"component health and armor : ", health, " / ",armor)	
	elif health <=0 and destroyed == false:
			on_destruction()

func _on_damage_recieved(damage:float):
				
				
#		check for overlapping boddies that are components
	if armor > 0:
		armor -= damage/2
		print("damage : ",damage, "component damaged : " , self.name,"component health and armor : ", health, " / ",armor)
	elif health > 0:
		health -= damage
		print("damage : ",damage, "component damaged : " , self.name,"component health and armor : ", health, " / ",armor)
	elif health <= 0 :
		print("COMPONENT DESTROYED:  ", self.name)
		var num_areas = get_overlapping_areas().size()
		for area in get_overlapping_areas():
			if area.has_method("_on_ghost_damage_recieved") :
				area._on_ghost_damage_recieved(damage/num_areas/2)

#		CHECK FOR OVERLAPPING BODIES< IF THOSE CAN TAKE DAMAGE SPREAD THE DAMAGE TO THEM, divide among all overlapping bodies
func on_destruction():
	if destroyed == false:
		print("COMPONENT DESTROYED:  ", self.name)
		var hitspark = EXPLOSION_COMPONENT.instantiate()
		#explosion.global_position = self.global_position
		
		get_parent().add_child(hitspark)
		hitspark.global_position = global_transform.origin 
		hitspark.rotation = rotation
		destroyed = true
	

	
	
