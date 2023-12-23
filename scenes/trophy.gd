extends Area2D
@export var target_level: PackedScene

@onready var game_manager = $"../../GameManager"

func _on_body_entered(body):
	if body.name == "Player" && game_manager.get_point() == 8:
		get_tree().change_scene_to_packed(target_level)
