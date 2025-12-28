#rear right
extends Component


var disabled = false


func _process(delta: float) -> void:
	if destroyed and !disabled:
		on_destroyed()
		








func on_destroyed():
	component_owner.max_speed *= 0.6
	disabled = true
