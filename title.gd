extends VBoxContainer

func _on_operation_request_2_button_down() -> void:
	$AudioStreamPlayer.play()
	# 登録した名前「SceneChanger」をそのまま使って関数を呼ぶ
	SceneChanger.change_scene("res://uis/japanese.tscn")


func _on_operation_request_button_down() -> void:
	$AudioStreamPlayer.play()
	# 登録した名前「SceneChanger」をそのまま使って関数を呼ぶ
	SceneChanger.change_scene("res://uis/english.tscn")
