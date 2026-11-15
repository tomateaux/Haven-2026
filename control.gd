extends Control

var level1_scene: PackedScene = preload("res://Level1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("proceed"):
			get_tree().change_scene_to_packed(level1_scene)
