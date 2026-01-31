extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	# 0.5秒かけて不透明度を0.3にし、その後0.5秒で0に戻す（ループさせる）
	tween.tween_property($DangerOverlay, "self_modulate:a", 0.3, 0.6)
	tween.tween_property($DangerOverlay, "self_modulate:a", 0.0, 0.59)
	tween.set_loops() # 敵が遠ざかるまでループ
