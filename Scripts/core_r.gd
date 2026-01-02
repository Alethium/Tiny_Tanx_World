# core rare
# this is engine compartment
extends Component
var disabled = false


func _process(delta: float) -> void:
	if destroyed and !disabled:
		on_destroyed()
		








func on_destroyed():
	component_owner.TOP_TURN_SPEED *= 0.5
	component_owner.cool_speed *= 0.5
	disabled = true
