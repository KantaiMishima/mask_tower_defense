extends VBoxContainer

# ゲームで一番使うボタンでスタートするようにする
func _on_start_anywhere_clicked():
	# 登録した名前「SceneChanger」をそのまま使って関数を呼ぶ
	SceneChanger.change_scene("res://mask_tower_defense.tscn")

func _input(event):
	# 「マウスの左ボタンが押された瞬間」だけを判定
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_start_anywhere_clicked()
