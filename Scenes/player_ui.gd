extends Control

@export var Observed_player : Player
# TODO
# collect the players stats and display them

@onready var paper_target: Node2D = $UI_frame_bottom/paper_target
@onready var enemy_paper_target: Node2D = $UI_frame_bottom/enemy_paper_target


@onready var components = []
@onready var paper_components = []


@onready var overheat: Control = $UI_frame_bottom/paper_target/Overheat_bar/Overheat


@onready var total_health: Control = $UI_frame_bottom/paper_target/Total_health
@onready var total_armor: Control = $UI_frame_bottom/paper_target/Total_armor

@onready var weapon_slot_ui_1: WeaponSlotUI = $UI_frame_bottom/weapon_slot_UI_1
@onready var weapon_slot_ui_2: WeaponSlotUI = $UI_frame_bottom/weapon_slot_UI_2
@onready var weapon_slot_ui_3: WeaponSlotUI = $UI_frame_bottom/weapon_slot_UI_3
@onready var weapon_slot_ui_4: WeaponSlotUI = $UI_frame_bottom/weapon_slot_UI_4



@onready var enemy_radar: EnemyRadar = $UI_frame_bottom/Radar_frame/Enemy_Radar

@onready var weapon_slots = [
	weapon_slot_ui_2,
	weapon_slot_ui_1,
	weapon_slot_ui_4,
	weapon_slot_ui_3,
]


@export var locked_on_player : Player










# overheat is a value out of 60.
# players max heat is 100.

# total health bars are out of 45
# total armor bars are out of 45


#TODO
# TIE all of the paper target pieces to the players component pieces. paper target, and component need to share the same name.



# Called when the node enters the scene tree for the first time.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Observed_player != null:
		handle_overheat_bar()
		handle_health_bars()
		update_player_stats(delta)
		handle_radar()
		handle_weapon_cooldown_bars()
		if locked_on_player != null:
			$UI_frame_bottom/enemy_paper_target.visible = true
			#print("locked on player  : ", locked_on_player)
			Observed_player.targeted_player = locked_on_player
			update_enemy_paper_target(locked_on_player)
			enemy_radar.display_tracked_enemies(Observed_player.target_dir,Observed_player.target_distance)
			if !enemy_radar.tracked_enemies.has(locked_on_player):
				enemy_radar.tracked_enemies.append(locked_on_player)
				
		else:
			$UI_frame_bottom/enemy_paper_target.visible = false
func handle_weapon_cooldown_bars():	
	weapon_slots[0].cooldown_bar.size.y = Observed_player.weapons[0].get_meter() * 29
	weapon_slots[1].cooldown_bar.size.y = Observed_player.weapons[1].get_meter() * 29
	weapon_slots[2].cooldown_bar.size.y = Observed_player.weapons[2].get_meter() * 29
	weapon_slots[3].cooldown_bar.size.y = Observed_player.weapons[3].get_meter() * 29

func handle_overheat_bar():
	overheat.size.y = Observed_player.overheat * 0.6
	
func handle_radar():
	enemy_radar.bottom_direction.rotation = Observed_player.bottom_dir
	enemy_radar.top_view.rotation = Observed_player.top_dir
	enemy_radar.rotation = -Observed_player.top_dir
	#print("target dir/dist : ", Observed_player.target_dir,"  ::  ",Observed_player.target_distance)
	


func handle_health_bars():
	total_armor.size.y = Observed_player.curr_armor/Observed_player.total_armor * 45
	total_health.size.y = Observed_player.curr_health/Observed_player.total_health * 45
	
func update_player_stats(delta):
#	for each of the components, get the shields and health, and disabled states and use that to change the associated 
	components = Observed_player.components
	paper_target.update_display(Observed_player)
	
	if Observed_player.overheat > 90.0:
		$Heat_vignette.modulate.a = lerpf($Heat_vignette.modulate.a,0.90,delta*0.5)
	elif Observed_player.overheat > 75.0:
		$Heat_vignette.modulate.a = lerpf($Heat_vignette.modulate.a,0.75,delta*0.5)
	elif Observed_player.overheat > 50.0:
		$Heat_vignette.modulate.a = lerpf($Heat_vignette.modulate.a,0.50,delta*0.5)
	else:
		$Heat_vignette.modulate.a = lerpf($Heat_vignette.modulate.a,0.0,delta)
	
	$Overheat_warning.visible = Observed_player.overheated
	if Observed_player.overheat >= 100:
		$Overheat_warning/overheat_warning.play()
		$Overheat_warning/overheat_warning2.play()
	
func update_enemy_paper_target(enemy):
	enemy_paper_target.update_display(enemy)
