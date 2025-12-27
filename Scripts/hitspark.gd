class_name HitSpark
extends Vfx
var timer = 18

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$"../spark".emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"../spark".emitting = true
	timer -= 1
	if timer < 13 :
		visible = false
		modulate.a -= 0.1
	if timer == 0:
		get_parent().queue_free()
		
