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

# overheat is a value out of 60.
# players max heat is 100.

# total health bars are out of 45
# total armor bars are out of 45


#TODO
# TIE all of the paper target pieces to the players component pieces. paper target, and component need to share the same name.



# Called when the node enters the scene tree for the first time.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handle_overheat_bar()
	handle_health_bars()
	update_player_stats()
	

func handle_overheat_bar():
	overheat.size.y = Observed_player.overheat * 0.6
	
	
func handle_health_bars():
	total_armor.size.y = Observed_player.curr_armor/Observed_player.total_armor * 45
	total_health.size.y = Observed_player.curr_health/Observed_player.total_health * 45
	
func update_player_stats():
#	for each of the components, get the shields and health, and disabled states and use that to change the associated 
	components = Observed_player.components
	
