class_name Explosion1
extends Vfx
@onready var vx_sprite: Sprite2D = $"Vx sprite"


var damage : float
@export var max_blast_size : float
@onready var blast_radius: Area2D = $blast_radius
@onready var blast_shape: CollisionShape2D = $blast_radius/blast_shape
var blast_size : float = 0
# i want to make it so an explosion has a little shock wave that goes out from it, 
#but that shock waves is the splash damage from the explosion and delivers damage to anything in it based on distance from the center
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	queue_redraw()
func _draw() -> void:
	draw_circle(vx_sprite.position,blast_size,Color.DARK_SALMON,false,2.0,false)
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	

	if blast_size < max_blast_size:
		#print("blast size : ", blast_size)
		blast_size += 2.0
		draw_blast_ring()
	
	blast_shape.shape.set_radius(blast_size)
	if blast_size >= max_blast_size:
		blast_radius.monitoring = false
	if blast_radius.monitoring == true:
		if blast_radius.get_overlapping_areas().size() > 0:
			var caught_in_blast = blast_radius.get_overlapping_areas()
			for target in caught_in_blast:
				if target.has_method("_on_damage_recieved"):
					print("target caught in the blast :  ", target, "  components owner :" ,target.component_owner)
					target._on_damage_recieved(damage/4)
					target.component_owner.cam.shake(2,1)
					Input.start_joy_vibration(target.component_owner.player_device,0.9,0.9,0.4)
	if sprite_index > frame_count:
		queue_free()
func draw_blast_ring():
	
	queue_redraw()
	
