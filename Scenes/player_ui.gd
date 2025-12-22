extends Control

@export var Observed_player : Player
# TODO
# collect the players stats and display them

@onready var paper_target_bg: Sprite2D = $UI_frame_bottom/paper_target/paper_target_bg
@onready var paper_target_cockpit: Sprite2D = $UI_frame_bottom/paper_target/paper_target_cockpit
@onready var paper_target_core_l: Sprite2D = $UI_frame_bottom/paper_target/paper_target_core_L
@onready var paper_target_core_r: Sprite2D = $UI_frame_bottom/paper_target/paper_target_core_R
@onready var paper_target_weapon_r_1: Sprite2D = $UI_frame_bottom/paper_target/paper_target_weapon_R1
@onready var paper_target_weapon_r_2: Sprite2D = $UI_frame_bottom/paper_target/paper_target_weapon_R2
@onready var paper_target_weapon_r_3: Sprite2D = $UI_frame_bottom/paper_target/paper_target_weapon_R3
@onready var paper_target_weapon_r_4: Sprite2D = $UI_frame_bottom/paper_target/paper_target_weapon_R4
@onready var paper_target_front_tread_l: Sprite2D = $UI_frame_bottom/paper_target/paper_target_front_tread_L
@onready var paper_target_rear_tread_l: Sprite2D = $UI_frame_bottom/paper_target/paper_target_rear_tread_L
@onready var paper_target_front_tread_r: Sprite2D = $UI_frame_bottom/paper_target/paper_target_front_tread_R
@onready var paper_target_rear_tread_r: Sprite2D = $UI_frame_bottom/paper_target/paper_target_rear_tread_R
@onready var paper_target_core_rear: Sprite2D = $UI_frame_bottom/paper_target/paper_target_core_rear
@onready var paper_target_core_front: Sprite2D = $UI_frame_bottom/paper_target/paper_target_core_front


@onready var overheat: Control = $UI_frame_bottom/Overheat
@onready var total_health: Control = $UI_frame_bottom/Total_health
@onready var total_armor: Control = $UI_frame_bottom/Total_armor

# overheat is a value out of 60.
# players max heat is 100.

# total health bars are out of 45
# total armor bars are out of 45


#TODO
# TIE all of the paper target pieces to the players component pieces. paper target, and component need to share the same name.



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_overheat_bar()
	handle_health_bars()
	

func handle_overheat_bar():
	overheat.size.y = Observed_player.overheat * 0.6
	
	
func handle_health_bars():
	total_armor.size.y = Observed_player.curr_armor/Observed_player.total_armor * 45
	total_health.size.y = Observed_player.curr_health/Observed_player.total_health * 45
	
