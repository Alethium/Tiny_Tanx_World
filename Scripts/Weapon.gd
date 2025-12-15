class_name Weapon
extends Area2D

@export var damage : float
@export var speed : float
@export var cooldown : float
@export var heat : float
@export var munition : PackedScene
@export var health : float
@export var spread: float

var cooldown_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cooldown_timer > 0 :
		cooldown_timer -= 1
