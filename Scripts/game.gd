extends Control
var respawn_timer = 60
@onready var player_1_view: SubViewport = $HBoxContainer/Player_1/player_1_view
@onready var player_2_view: SubViewport = $HBoxContainer/Player_2/player_2_view
@export var player_1 : Player
@export var player_2 : Player
var players = [player_1,player_2]
const PLAYER_MECH = preload("uid://cx1y1p4ehilni")
@onready var level: Node2D = $HBoxContainer/Player_1/player_1_view/level
const PLAYER_2_CONTROLS = preload("uid://djbf4ibjvpqxp")
const PLAYER_1_CONTROLS = preload("uid://m2sjqkxfifmj")
@onready var player_2_ui: Control = $PLAYER_UI2
@onready var player_1_ui: Control = $PLAYER_UI
@onready var player_1_bulbs: Node2D = $"life_meter/Life_meter/Player_1 bulbs"
@onready var player_2_bulbs: Node2D = $"life_meter/Life_meter/Player_2 bulbs"
var spawned_in = false

#---------------main menu--------------
# two side by sidearcade machines.
# insert coin screen, press left shift  on left screen or A/cross button to designate a controller as left side,
 #press right shift on right screen or B/square to designate a controller to the left side, 
# or click/tap insert coin button, to get to menu on associated machine
# when one player has begun but is waiting for the other player the top menu item goes from battle! to practice,or tutorial.
# in practice / tutorial it will teach you how the tank works. guide you through the mech builder, tell you what all the parts do, let you assemble a tank,
# and then drop you in a single player practice field, where you can shoot at targets in a course for a time. all the targets would show as dots ont he rader, it could be speed run, maybe have a leaderboard. 
# if a second 
# 








# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_in()

	player_2_view.world_2d = player_1_view.find_world_2d()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:


		
		
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()





# feed this two mech builds created by the player in the mech creator.


func spawn_in():

	
	var spawning_player = PLAYER_MECH.instantiate()
	var new_spawn = level.spawn_points_array[randi_range(0,3)]
	player_2 = spawning_player
	spawning_player.player_index = 2
	player_2.Controls = PLAYER_2_CONTROLS.duplicate()
	player_2.Controls.player_index = 1
	player_2_view.add_child((spawning_player))
	spawning_player.global_position = new_spawn.global_position
	spawning_player.bottom_dir = (new_spawn.global_rotation)
	spawning_player.top_dir = (new_spawn.global_rotation)
	spawning_player.current_lives = 4
	print("spawning player 2 at : ", new_spawn.global_position)
	player_2_ui.Observed_player = player_2
	
	player_2.player_name = "Player_2"
	player_2.connect("on_death",on_player_death)
	spawning_player = PLAYER_MECH.instantiate()
	new_spawn = level.spawn_points_array[randi_range(8,11)]
	player_1 = spawning_player
	spawning_player.player_index = 1
	player_1.Controls = PLAYER_1_CONTROLS.duplicate()
	player_1.Controls.player_index = 0
	player_1_view.add_child((spawning_player))
	spawning_player.global_position = new_spawn.global_position
	spawning_player.bottom_dir = (new_spawn.global_rotation)
	spawning_player.top_dir = (new_spawn.global_rotation)
	spawning_player.current_lives = 4
	print("spawning player 1", new_spawn.global_position) 
	player_1_ui.Observed_player = player_1
	player_1_ui.CRT_filter.viewport_player_index = 1
	player_1.player_name = "Player_1"
	player_1.connect("on_death",on_player_death)

	player_1_ui.locked_on_player = player_2
	player_2_ui.locked_on_player = player_1

func on_player_death(player,lives_remaining):
	if player == "Player_2":
		player_2_bulbs.get_child(lives_remaining-1).toggle_light()
	elif player == "Player_1":
		player_1_bulbs.get_child(lives_remaining-1).toggle_light()
	
	print_rich("[b]DEAD PLAYER[b] : ", player)
	var respawning_player = PLAYER_MECH.instantiate()
	
	
	var furthest_points = []
	#var max_distance: float = 0.0
	for spawn in level.spawn_points_array:
		#print("Spawn!!",spawn,"position : ",spawn.global_position,"" )
		
		var distance: float 
		if player == "Player_2":
			distance = spawn.global_position.distance_to(player_1.global_position)
		elif player == "Player_1":
			distance = spawn.global_position.distance_to(player_2.global_position)
		
		
		if distance > 1000:
			#max_distance = distance
			furthest_points.append(spawn)
	var new_spawn = furthest_points[randi_range(0,furthest_points.size()-1)]
	
	if player == "Player_2":
		player_2 = respawning_player
		player_2.Controls = PLAYER_2_CONTROLS.duplicate()
		player_2.Controls.player_index = 2
		player_2.player_device = 1
		player_2.player_color = Color.LIGHT_SKY_BLUE
		player_2_view.add_child((respawning_player))
		respawning_player.global_position = new_spawn.global_position
		respawning_player.bottom_dir = (new_spawn.global_rotation)
		respawning_player.top_dir = (new_spawn.global_rotation)
		respawning_player.current_lives = lives_remaining
		print("respawning player 2 at : ", new_spawn.global_position)
		player_2_ui.Observed_player = player_2
		player_2_ui.CRT_filter.viewport_player_index = 1
		player_1_ui.locked_on_player = player_2
		player_2.player_name = "Player_2"
		player_2.connect("on_death",on_player_death)
	elif player == "Player_1":
		player_1 = respawning_player
		player_1.Controls = PLAYER_1_CONTROLS.duplicate()
		player_1.Controls.player_index = 1
		player_1.player_device = 0
		player_1.player_color = Color.HOT_PINK
		player_1_view.add_child((respawning_player))
		respawning_player.global_position = new_spawn.global_position
		respawning_player.bottom_dir = (new_spawn.global_rotation)
		respawning_player.top_dir = (new_spawn.global_rotation)
		respawning_player.current_lives = lives_remaining
		print("respawning player 1", new_spawn.global_position) 
		player_1_ui.Observed_player = player_1
		player_1_ui.CRT_filter.viewport_player_index = 1
		player_2_ui.locked_on_player = player_1
		player_1.player_name = "Player_1"
		player_1.connect("on_death",on_player_death)
	
