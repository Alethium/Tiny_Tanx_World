class_name Weapon
extends Component

@export var damage : float
@export var speed : float
@export var cooldown : float
@export var heat : float
@export var munition : PackedScene
@export var spread: float

var gun_owner 

var cooldown_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gun_owner = get_parent().get_parent().get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cooldown_timer > 0 :
		cooldown_timer -= 1
