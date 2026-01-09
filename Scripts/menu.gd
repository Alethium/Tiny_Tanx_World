class_name Menu
extends Node2D


@onready var active : bool
@onready var control_index : int
@onready var owner_index : int
@export var Controls: Resource = null


func _ready() -> void:
	Controls = get_parent().Controls
