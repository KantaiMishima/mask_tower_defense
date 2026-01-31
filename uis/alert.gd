extends HBoxContainer

# 重なっている敵の数を管理
var enemies_in_area: int = 0
var tween: Tween = null

func play_sound() -> void:
	# 既存のTweenを停止して新しいものを作成
	if tween:
		tween.kill()
	tween = create_tween()
	# 0.5秒かけて不透明度を0.3にし、その後0.5秒で0に戻す（ループさせる）
	tween.tween_property($DangerOverlay, "self_modulate:a", 0.3, 0.6)
	tween.tween_property($DangerOverlay, "self_modulate:a", 0.0, 0.59)
	tween.set_loops() # 敵が遠ざかるまでループ
	
	# 音を再生
	if $AudioStreamPlayer2D and not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()

func stop_sound() -> void:
	# Tweenを停止
	if tween:
		tween.kill()
		tween = null
	# オーバーレイを完全に透明に
	$DangerOverlay.self_modulate.a = 0.0
	# 音を停止
	if $AudioStreamPlayer2D:
		$AudioStreamPlayer2D.stop()

func _area_show_item(area: Area2D) -> void:
	# 敵のAttackmotionエリアかどうかを確認
	if area.get_parent().is_in_group("enemy"):
		enemies_in_area += 1
		if enemies_in_area == 1:  # 最初の敵が入った時だけ表示・音再生
			show()
			play_sound()
		print("show - enemy detected (total: ", enemies_in_area, ")")

func _area_hide_item(area: Area2D) -> void:
	# 敵のAttackmotionエリアかどうかを確認
	if area.get_parent().is_in_group("enemy"):
		enemies_in_area -= 1
		# 全ての敵がいなくなった時のみ非表示
		if enemies_in_area <= 0:
			enemies_in_area = 0  # 念のため0にリセット
			hide()
			stop_sound()
			print("hide - all enemies left")
		else:
			print("enemy left (remaining: ", enemies_in_area, ")")
