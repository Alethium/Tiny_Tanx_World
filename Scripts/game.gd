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



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_1.connect("on_death",on_player_death)
	player_2.connect("on_death",on_player_death)
	player_2_view.world_2d = player_1_view.find_world_2d()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

		
	#if spawned_in == false:
		#
		#spawn_in()
		
			
		
		
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

#func spawn_in():
	#respawn_timer -= 1
	#
	#print("SPAWNING PLAYERS")
	#
	#var furthest_points = []
	##var max_distance: float = 0.0
	#for spawn in level.spawn_points_array:
		#print("Spawn!!",spawn,"position : ",spawn.global_position,"" )
		#
		#var distance: float 
		#if player == "Player_2":
			#distance = spawn.global_position.distance_to(player_1.global_position)
		#elif player == "Player_1":
			#distance = spawn.global_position.distance_to(player_2.global_position)
		#
		#
		#if distance > 1000:
			##max_distance = distance
			#furthest_points.append(spawn)
	#var new_spawn = furthest_points[randi_range(0,furthest_points.size()-1)]
	#
	#if player == "Player_2":
		#player_2 = respawning_player
		#player_2.Controls = PLAYER_2_CONTROLS.duplicate()
		#player_1.Controls.player_index = 2
		#player_2_view.add_child((respawning_player))
		#respawning_player.global_position = new_spawn.global_position
		#respawning_player.bottom_dir = (new_spawn.global_rotation)
		#respawning_player.top_dir = (new_spawn.global_rotation)
		#respawning_player.current_lives = lives_remaining
		#print("respawning player 2 at : ", new_spawn.global_position)
		#player_2_ui.Observed_player = player_2
		#player_1_ui.locked_on_player = player_2
		#player_2.player_name = "Player_2"
		#player_2.connect("on_death",on_player_death)
	#elif player == "Player_1":
		#player_1 = respawning_player
		#player_1.Controls = PLAYER_1_CONTROLS.duplicate()
		#player_1.Controls.player_index = 1
		#player_1_view.add_child((respawning_player))
		#respawning_player.global_position = new_spawn.global_position
		#respawning_player.bottom_dir = (new_spawn.global_rotation)
		#respawning_player.top_dir = (new_spawn.global_rotation)
		#respawning_player.current_lives = lives_remaining
		#print("respawning player 1", new_spawn.global_position) 
		#player_1_ui.Observed_player = player_1
		#player_2_ui.locked_on_player = player_1
		#player_1.player_name = "Player_1"
		#player_1.connect("on_death",on_player_death)
	

func on_player_death(player,lives_remaining):
	if player == "Player_2":
		player_2_bulbs.get_child(lives_remaining-1).toggle_light()
	elif player == "Player_1":
		player_1_bulbs.get_child(lives_remaining-1).toggle_light()
	
	print("RESPAWNING DEAD PLAYER : ", player)
	var respawning_player = PLAYER_MECH.instantiate()
	
	
	var furthest_points = []
	#var max_distance: float = 0.0
	for spawn in level.spawn_points_array:
		print("Spawn!!",spawn,"position : ",spawn.global_position,"" )
		
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
		player_1.Controls.player_index = 2
		player_2.player_color = Color.LIGHT_SKY_BLUE
		player_2_view.add_child((respawning_player))
		respawning_player.global_position = new_spawn.global_position
		respawning_player.bottom_dir = (new_spawn.global_rotation)
		respawning_player.top_dir = (new_spawn.global_rotation)
		respawning_player.current_lives = lives_remaining
		print("respawning player 2 at : ", new_spawn.global_position)
		player_2_ui.Observed_player = player_2
		player_1_ui.locked_on_player = player_2
		player_2.player_name = "Player_2"
		player_2.connect("on_death",on_player_death)
	elif player == "Player_1":
		player_1 = respawning_player
		player_1.Controls = PLAYER_1_CONTROLS.duplicate()
		player_1.Controls.player_index = 1
		player_1.player_color = Color.HOT_PINK
		player_1_view.add_child((respawning_player))
		respawning_player.global_position = new_spawn.global_position
		respawning_player.bottom_dir = (new_spawn.global_rotation)
		respawning_player.top_dir = (new_spawn.global_rotation)
		respawning_player.current_lives = lives_remaining
		print("respawning player 1", new_spawn.global_position) 
		player_1_ui.Observed_player = player_1
		player_2_ui.locked_on_player = player_1
		player_1.player_name = "Player_1"
		player_1.connect("on_death",on_player_death)
	
