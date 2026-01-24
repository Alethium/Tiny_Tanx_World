# cockpit
# this is engine compartment
extends Component
@onready var player: Player = $"../../.."
@onready var detonated = false
func _process(delta: float) -> void:
	if destroyed == true  and detonated == false:
		on_destroyed()

func on_destroyed():
	
	print("cockpit destroyed player dead : ", component_owner)
	player._on_destroyed()
	detonated = true
	
 #KILL THE PLAYER
