class_name Component
extends Area2D

@export var health : float
@export var armor : float
@export var paper_target : Sprite2D
@onready var starting_health = health
@onready var starting_armor = armor
@export var component_owner = Player



	


func _on_damage_recieved(damage:int):
	
	if armor > 0:
		armor -= damage
		print("damage : ",damage, "component damaged : " , self.name,"component health and armor : ", health, " / ",armor)
	elif health > 0:
		health -= damage
		print("damage : ",damage, "component damaged : " , self.name,"component health and armor : ", health, " / ",armor)
	if health <= 0 :
		print("component_destroyed", self.name,"component health and armor : ", health, " / ",armor)
		
	
	
