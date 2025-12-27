# cockpit
# this is engine compartment
extends Component
@onready var player: Player = $"../../.."


func on_destroyed():
	print("cockpit destroyed player dead : ", component_owner)
	player._on_destroyed()
	
	
 #KILL THE PLAYER
