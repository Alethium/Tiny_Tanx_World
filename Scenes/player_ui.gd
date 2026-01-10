extends Control
@onready var ready_up = false
@export var Observed_player : Player
@export var Controls: Resource = null
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

@onready var CRT_filter: CRT = %CanvasLayer


@export var CRT_filter_index: int 


enum MenuState {TITLE,START,GARAGE,SETTINGS,PAUSE,CLOSED}
@onready var menu_state := MenuState.START	
@onready var title_screen: Node2D = $Title_screen
@onready var start_menu: Node2D = $Start_menu
@onready var settings_menu: Node2D = $Settings_menu
@onready var garage_menu: Node2D = $Garage_menu
@onready var pause_menu: Node2D = $Pause_menu
@export var player_index : int


			
func handle_menues():
	#print("menu state",menu_state)
	if menu_state == MenuState.TITLE:
		title_screen.active = true
		title_screen.owner_index = player_index
	elif menu_state == MenuState.START:
		start_menu.active = true
		start_menu.visible = true
		start_menu.owner_index = player_index
	elif menu_state == MenuState.GARAGE:
		garage_menu.active = true
	elif menu_state == MenuState.SETTINGS:
		settings_menu.active = true
	elif menu_state == MenuState.PAUSE:
		pause_menu.active = true
	elif menu_state == MenuState.CLOSED:
		pass




#TODO
# set up player control interactions for title screen
# left screen press a to start, right screen press x.
# assign the controler device id of the controler that presses a/x to the correct player side
# likely need to make the two controller sets	
func _ready() -> void:
	menu_state = MenuState.TITLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	CRT_filter.player_index = CRT_filter_index
	CRT_filter.set_screen(CRT_filter_index)
	handle_menues()
	if Observed_player != null:
		
		handle_player_UI(delta)
	




func handle_player_UI(delta):
	CRT_filter.player_index = CRT_filter_index
	CRT_filter.set_screen(Observed_player.player_index)
	handle_overheat_bar()
	handle_health_bars()
	update_player_stats(delta)
	handle_radar()
	handle_throttle_bar()
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
	weapon_slots[0].health_bar.modulate = paper_target.health_components[9].modulate
	weapon_slots[1].health_bar.modulate = paper_target.health_components[10].modulate
	weapon_slots[2].health_bar.modulate = paper_target.health_components[11].modulate
	weapon_slots[3].health_bar.modulate = paper_target.health_components[12].modulate

	weapon_slots[0].cooldown_bar.size.y = Observed_player.weapons[0].get_meter() * 29
	weapon_slots[1].cooldown_bar.size.y = Observed_player.weapons[1].get_meter() * 29
	weapon_slots[2].cooldown_bar.size.y = Observed_player.weapons[2].get_meter() * 29
	weapon_slots[3].cooldown_bar.size.y = Observed_player.weapons[3].get_meter() * 29
	weapon_slots[0].set_icon(Observed_player.weapons[0])
	weapon_slots[1].set_icon(Observed_player.weapons[1])
	weapon_slots[2].set_icon(Observed_player.weapons[2])
	weapon_slots[3].set_icon(Observed_player.weapons[3])
	if Observed_player.weapons[0].disabled:
		weapon_slots[0].weapon_disabled.visible = true
	elif Observed_player.weapons[0].destroyed:
		weapon_slots[0].weapon_disabled.visible = true
		weapon_slots[0].weapon_destroyed.visible = true
	else:
		weapon_slots[0].weapon_disabled.visible = false
		weapon_slots[0].weapon_destroyed.visible = false
	
	if Observed_player.weapons[1].disabled:
		weapon_slots[1].weapon_disabled.visible = true
	elif Observed_player.weapons[1].destroyed:
		weapon_slots[1].weapon_disabled.visible = true
		weapon_slots[1].weapon_destroyed.visible = true
	else:
		weapon_slots[1].weapon_disabled.visible = false
		weapon_slots[1].weapon_destroyed.visible = false
		
	if Observed_player.weapons[2].disabled:
		weapon_slots[2].weapon_disabled.visible = true
	elif Observed_player.weapons[2].destroyed:
		weapon_slots[2].weapon_disabled.visible = true
		weapon_slots[2].weapon_destroyed.visible = true
	else:
		weapon_slots[2].weapon_disabled.visible = false
		weapon_slots[2].weapon_destroyed.visible = false		

	if Observed_player.weapons[3].disabled:
		weapon_slots[3].weapon_disabled.visible = true
	elif Observed_player.weapons[3].destroyed:
		weapon_slots[3].weapon_disabled.visible = true
		weapon_slots[3].weapon_destroyed.visible = true
	else:
		weapon_slots[3].weapon_disabled.visible = false
		weapon_slots[3].weapon_destroyed.visible = false
func handle_overheat_bar():
	overheat.size.y = Observed_player.overheat * 0.6

func handle_throttle_bar():
	$UI_frame_bottom/paper_target/throttle_bar/throttle_bar.scale.y = Observed_player.current_throttle/Observed_player.max_throttle * 7.15

	
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
