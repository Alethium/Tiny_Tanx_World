class_name Component
extends Area2D
@export var sprite : Sprite2D
@export var sprites = []
@export var health : float
@export var armor : float
@export var paper_target : Sprite2D
@onready var starting_health = health
@onready var starting_armor = armor
@export var component_owner : Player
var destroyed = false
var disabled = false
const EXPLOSION_COMPONENT = preload("uid://t148unhpctq0")


func _ready() -> void:
	for child in get_children():
		if child is Sprite2D:
			sprites.append(child)
	

		
func _on_ghost_damage_recieved(damage:float):
	if armor > 0:
		if component_owner.overheated == true:
			apply_blink(Color.RED,0.3)
		else:
			apply_blink(Color.WHITE,0.5)
		armor -= damage/2
		#apply_blink(Color.DIM_GRAY)
		#print("damage : ",damage, "component ghost damaged : " , self.name,"component health and armor : ", health, " / ",armor)
	elif health > 0:
		if component_owner.overheated == true:
			apply_blink(Color.RED,0.3)
		else:
			apply_blink(Color.WHITE,0.7)
		health -= damage
		#apply_blink(Color.DARK_GRAY)
		#print("damage : ",damage, "component ghost damaged : " , self.name,"component health and armor : ", health, " / ",armor)	
	elif health <=0 and destroyed == false:
			on_destruction()

func _on_damage_recieved(damage:float):
				
				
#		check for overlapping boddies that are components
	if armor > 0:
		armor -= damage/2
		apply_blink(Color.WHITE,0.3)
		if component_owner.overheated == true:
			apply_blink(Color.RED,0.3)
		else:
			apply_blink(Color.WHITE,0.3)
		#print("damage : ",damage, "component damaged : " , self.name,"component health and armor : ", health, " / ",armor)
	elif health > 0:
		health -= damage
		if component_owner.overheated == true:
			apply_blink(Color.RED,0.3)
		else:
			apply_blink(Color.WHITE,0.5)
		#print("damage : ",damage, "component damaged : " , self.name,"component health and armor : ", health, " / ",armor)
	elif health <= 0 :
		if component_owner.overheated == true:
			apply_blink(Color.RED,0.3)
		else:
			apply_blink(Color.WHITE,0.7)
		#print("COMPONENT DESTROYED:  ", self.name)
		var num_areas = get_overlapping_areas().size()
		for area in get_overlapping_areas():
			if area.has_method("_on_ghost_damage_recieved") :
				area._on_ghost_damage_recieved(damage/num_areas)

#		CHECK FOR OVERLAPPING BODIES< IF THOSE CAN TAKE DAMAGE SPREAD THE DAMAGE TO THEM, divide among all overlapping bodies
func on_destruction():
	if destroyed == false:
		#print("COMPONENT DESTROYED:  ", self.name)
		var hitspark = EXPLOSION_COMPONENT.instantiate()
		#explosion.global_position = self.global_position
		
		get_parent().add_child(hitspark)
		hitspark.global_position = global_transform.origin 
		hitspark.rotation = rotation
		destroyed = true
func apply_blink(color,intensity):
	set_shader_color(color)
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_blink_intensity,intensity,0.0,0.2)
	
func set_shader_color(newcolor):
	for _sprite in sprites:
		_sprite.material.set_shader_parameter("blink_color",newcolor)
		
func set_shader_blink_intensity(newvalue:float):
	for _sprite in sprites:
	
		_sprite.material.set_shader_parameter("blink_intensity",newvalue)
	
	
	
	
