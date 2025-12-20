# bullet.gd

class_name CannonLG
extends Projectile  

var impacted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _physics_process(delta):
	handle_animation()
	
	position += direction * speed * delta






func handle_animation():
	sprite_index += 0.1
	if sprite_index > 3:
		sprite_index = 0
	sprite.frame = sprite_index
func move(delta):
	global_position += direction * speed * delta	
	






func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()


func impact():
	impacted = true
	var hitspark = impact_effect.instantiate()
	#explosion.global_position = self.global_position
	sprite.visible = false
	set_deferred("monitoring",false)
	set_deferred("monitorable",false)
	
	get_parent().add_child(hitspark)
	hitspark.global_position = sprite.global_transform.origin 
	hitspark.rotation = rotation
	queue_free()
		
func _on_area_entered(area):
	if area.has_method("_on_damage_recieved") and area.component_owner != projectile_owner:
		area._on_damage_recieved(damage)
		impact()
	
	


func _on_body_impacted(body: Node2D) -> void:
	if impacted == false:
		impact()
