extends AudioStreamPlayer








func _process(_delta: float) -> void:
	await finished
	play()
