extends Control

var level1_scene: PackedScene = preload("res://Level1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(15):
		await get_tree().create_timer(0.1).timeout
		BGM.volume_db += 1.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("proceed"):
			for i in range(15):
				await get_tree().create_timer(0.1).timeout
				BGM.volume_db -= 1.0
			get_tree().change_scene_to_packed(level1_scene)
