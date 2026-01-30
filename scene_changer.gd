extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_in")

func change_scene(path: String):
	# 1. フェードアウト開始
	animation_player.play("fade_out")
	await animation_player.animation_finished
	
	# 2. シーン切り替え
	get_tree().change_scene_to_file(path)
	
	# 3. フェードイン開始
	animation_player.play("fade_in")
