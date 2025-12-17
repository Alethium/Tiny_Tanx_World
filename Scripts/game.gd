extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Player_2/SubViewport.world_2d = $HBoxContainer/Player_1/player_1_view.find_world_2d()
# Called every frame. 'delta' is the elapsed time since the previous frame.
