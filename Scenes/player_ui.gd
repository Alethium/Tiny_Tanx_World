extends Control

@export var Observed_player : Player
# TODO
# collect the players stats and display them

@onready var paper_target: Node2D = $UI_frame_bottom/paper_target


@onready var components = []
@onready var paper_components = []

@onready var overheat: Control = $UI_frame_bottom/Overheat
@onready var total_health: Control = $UI_frame_bottom/Total_health
@onready var total_armor: Control = $UI_frame_bottom/Total_armor


@onready var weapon_cooldown_r_1: Control = $UI_frame_bottom/Laser/Weapon_cooldown_r1
@onready var weapon_cooldown_r_2: Control = $UI_frame_bottom/MachineGun/Weapon_cooldown_r2
@onready var weapon_cooldown_r_3: Control = $UI_frame_bottom/Cannon/Weapon_cooldown_r3
@onready var weapon_cooldown_r_4: Control = $UI_frame_bottom/rockets/Weapon_cooldown_r4


@onready var enemy_paper_target: Node2D = $UI_frame_bottom/enemy_target/enemy_paper_target

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
	if locked_on_player != null:
		%enemy_target.visible = true
		#print("locked on player  : ", locked_on_player)
		update_enemy_paper_target(locked_on_player)
	else:
		%enemy_target.visible = false
		

func handle_overheat_bar():
	overheat.size.y = Observed_player.overheat * 0.6
	
	
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
