extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:# 1. 1.0秒待つ（シーンツリーにタイマーを作成して、その終了を待機）
	await get_tree().create_timer(1.0).timeout
	
	# 2. 自分自身を安全に消去する
	queue_free()
