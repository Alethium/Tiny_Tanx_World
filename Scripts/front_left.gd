#front left
extends Component



func _process(delta: float) -> void:
	if destroyed and !disabled:
		on_destroyed()
		








func on_destroyed():
	component_owner.BOTTOM_TURN_SPEED *= 0.5
	disabled = true
	
	
	
	
#	fuck up the player speed
#	and pull to the side
