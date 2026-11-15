extends Node

var level2_scene: PackedScene = preload("res://Level2.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("proceed"):
		get_tree().change_scene_to_packed(level2_scene)
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
