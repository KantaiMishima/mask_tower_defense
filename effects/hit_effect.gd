extends Node2D
	
func flash_item():
	# 1. 自分を表示する
	show() # または visible = true
	$AudioStreamPlayer2D.play()
	
	# 2. 1.0秒待機する
	await get_tree().create_timer(1.0).timeout
	
	# 3. 自分を非表示にする
	hide() # または visible = false


func _on_attackmotion_2_body_entered(body: Node2D) -> void:
	flash_item()
	pass # Replace with function body.


func _on_attackmotion_3_body_entered(body: Node2D) -> void:
	flash_item()
	pass # Replace with function body.
