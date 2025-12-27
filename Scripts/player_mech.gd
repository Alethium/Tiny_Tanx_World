class_name Player
extends CharacterBody2D

@onready var cam: Camera2D = $Player_cam


@onready var top_half: Node2D = $top_half
@onready var bottom_half: Node2D = $bottom_half

@export var SPEED = 30.0
@export var TOP_TURN_SPEED = 3.0
@export var BOTTOM_TURN_SPEED = 2.0
@export var ACCELLERATION = 40.0


@onready var bottom_hitbox: CollisionShape2D = $bottom_hitbox
@onready var cannon: Cannon = $top_half/weapon_slots/left_arm_weapon_slot/Cannon
@onready var laser: Laser = $top_half/weapon_slots/right_arm_weapon_slot/Laser
@onready var machine_gun: MachineGun = $top_half/weapon_slots/right_shoulder_weapon_slot/Machine_gun
@onready var srm_4: MissileLauncher = $top_half/weapon_slots/left_shoulder_weapon_slot/SRM_4



@onready var front_left: Area2D = %front_left
@onready var front_right: Area2D = %front_right
@onready var rear_left: Area2D = %rear_left
@onready var rear_right: Area2D = %rear_right
@onready var front_mid: Area2D = %front_mid

@onready var core_l: Area2D = %Core_L
@onready var cockpit: Area2D = %Cockpit
@onready var core_r: Area2D = %Core_R
@onready var core_rear: Area2D = %Core_Rear


# TODO in future make this list populate the weapons on ready from whatever the player has selected for weapons. 
@onready var components = [
	front_left,
	front_right,
	rear_left,
	rear_right,
	front_mid,
	core_rear,
	core_l,
	core_r,
	cockpit,
	laser,
	cannon,
	machine_gun,
	srm_4
]




func _ready():
	for part in components:
		part.component_owner = self
	
	
@onready var hitboxes = [
	front_left,
	front_right,
	rear_left,
	rear_right,
	front_mid,
	core_rear,
	core_l,
	core_r,
	cockpit,
]

@export var Controls: Resource = null


@onready var left_arm_weapon_slot: Node2D = $top_half/weapon_slots/left_arm_weapon_slot
@onready var right_arm_weapon_slot: Node2D = $top_half/weapon_slots/right_arm_weapon_slot
@onready var right_shoulder_weapon_slot: Node2D = $top_half/weapon_slots/right_shoulder_weapon_slot
@onready var left_shoulder_weapon_slot: Node2D = $top_half/weapon_slots/left_shoulder_weapon_slot

var weapon_slots = [
	left_arm_weapon_slot,
	right_arm_weapon_slot,
	right_shoulder_weapon_slot,
	left_shoulder_weapon_slot
]

var bottom_dir = 0.0
var top_dir = 0.0
var throttle = 0.0

@export var max_speed : float
var acceleration = 400.0
var current_speed = 0.0
var current_throttle : float = 0.0
@export var health : int
@export var overheat = 0
var max_heat = 100
var overheated = false
var total_armor : int = -1
var total_health : int = -1

var curr_health = 0
var curr_armor = 0
enum ControlStyles {Complex,Simple,Twinstick}
var control_style = ControlStyles.Complex




	
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	
	handle_inputs(delta)
	apply_movement(delta)
	

	# Handle heat
	overheat -= 0.1
	overheat = clamp(overheat,0,max_heat)
	if overheat == max_heat:
		overheated = true
		
	if overheated and overheat <= 50:
		overheated = false	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	

	update_total_health_bars()
	move_and_slide()






func handle_inputs(delta):
	
	
	
	if control_style == ControlStyles.Complex:
		if !overheated:
			if Input.is_action_pressed(Controls.rotate_bottom_left):
				bottom_dir -= BOTTOM_TURN_SPEED * delta
				top_dir -= BOTTOM_TURN_SPEED * delta
			if Input.is_action_pressed(Controls.rotate_bottom_right):
				bottom_dir += BOTTOM_TURN_SPEED * delta
				top_dir += BOTTOM_TURN_SPEED * delta
			if Input.is_action_pressed(Controls.rotate_top_left):
				top_dir -= TOP_TURN_SPEED * delta
			if Input.is_action_pressed(Controls.rotate_top_right):
				top_dir += TOP_TURN_SPEED * delta

			# Movement input - accelerate forward/backward
		if !overheated:	
			throttle = Input.get_axis(Controls.throttle_down, Controls.throttle_up)
			current_throttle -= throttle 
		else:
			current_throttle = lerp(current_throttle,0.0,delta) 
	 
	
	
	

		# Accelerate in the direction of input
	current_throttle = clamp(current_throttle, -50, 50)
	top_half.global_rotation = top_dir
	bottom_half.global_rotation = bottom_dir
	current_speed = current_throttle 
	current_speed = clamp(current_speed, -max_speed, max_speed)
	#print("current speed : ",current_speed)
	if Input.is_action_pressed(Controls.brake):
		current_throttle = lerp(current_throttle,0.0,delta) 
		
		if abs(current_speed) < 15:
			current_speed= 0
			current_throttle = 0
		
	if !overheated:	
		if Input.is_action_pressed(Controls.fire_left_weapon_1): 
			left_arm_weapon_slot.get_children()[0].fire(top_dir)
		if Input.is_action_pressed(Controls.fire_left_weapon_2):
			left_shoulder_weapon_slot.get_children()[0].fire(top_dir)
		if Input.is_action_pressed(Controls.fire_right_weapon_2): 
			right_shoulder_weapon_slot.get_children()[0].fire(top_dir)
		if Input.is_action_pressed(Controls.fire_right_weapon_1): 
			right_arm_weapon_slot.get_children()[0].fire(top_dir)
		
func apply_movement(delta):
	
	# Add 90 degrees to align with sprite's forward
	var adjusted_angle = bottom_dir + deg_to_rad(90)  # Assuming bottom_dir is in radians
	var move_direction = Vector2(cos(adjusted_angle), sin(adjusted_angle))
	
	velocity = move_direction * current_speed
	global_position += velocity * delta
	bottom_hitbox.rotation = bottom_half.rotation
	
	
func update_total_health_bars():

	var temp_health = 0
	var temp_armor = 0
	if total_health == -1 :
		for part in components:
			total_armor += part.armor
			total_health += part.health			
	
		
	for part in components:
		temp_armor += part.armor
		temp_health += part.health	
		
	curr_armor = temp_armor
	curr_health = temp_health

	
	
	
	
