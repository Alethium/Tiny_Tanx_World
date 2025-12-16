class_name Laser
extends Weapon

@export var effective_range : int
@export var pulse_length : float
@onready var raycast: RayCast2D = $RayCast2D
@export var ray_offset_x : int
@export var ray_offset_y : int
var firing = false
var pulse_timer = 0
var hit_point : Vector2
var ray_set = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()
	



func _process(delta: float) -> void:
	if ray_set == false:
		setup_raycast()
	if cooldown_timer > 0 :
		cooldown_timer -= 1
		cooldown_timer -= 1
	if firing:
		pulse_timer -= 1
		if raycast.get_collider() != null:
			hit_point = to_local(raycast.get_collision_point())
			#print("colliding")
			#print(raycast.get_collider())
			if raycast.get_collider().has_method("on_damage_recieved"):
				raycast.get_collider().on_damage_recieved(damage)
			#if raycast.get_collider().has_method("on_damage_recieved"):
				#raycast.get_collider().get_parent().on_damage_recieved(damage)
		else:
			hit_point = raycast.target_position		

	
	if pulse_timer == 0:
		firing = false
		
		
		
	queue_redraw()
	


func fire(_dir):
	print("firing  laser cooldown :",cooldown_timer,"pulse time : ",pulse_timer)
	
	if cooldown_timer == 0:
		cooldown_timer += cooldown
		pulse_timer = pulse_length
		firing = true
# 		instantiate a raycast straight out of the laser at the distance of the range of the laser
# 		do a draw of a line between the target point of the laser 
# 		if raycast collides with an area, it needs to make that distance the end of the laser. cant have it passing through things.
# 		laser confers damage per frame, it turns on, then turns off.
func _draw() -> void:
	if firing:
		draw_line(Vector2(position.x+ray_offset_x+1,position.y+ray_offset_y),hit_point,Color.PALE_GREEN,1,true)
		draw_line(Vector2(position.x+ray_offset_x,position.y+ray_offset_y),hit_point,Color.WHITE,1,true)
		draw_line(Vector2(position.x+ray_offset_x-1,position.y+ray_offset_y),hit_point,Color.PALE_GREEN,1,true)	
		
	#else:
		#raycast.enabled = false
	
func setup_raycast():
	#print(get_parent().get_parent().get_parent().get_parent().name)
	# Add nodes to exclude
	for area in get_parent().get_parent().get_parent().get_parent().hitboxes:
			print(area.name)
			raycast.add_exception(area)
	ray_set = true
	
