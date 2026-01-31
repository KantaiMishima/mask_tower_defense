extends TextureProgressBar

# 1秒間に減らしたい量（例：10なら10秒で100から0になる）
@export var decrease_speed: float = 10.0

func _process(delta):
	# delta（1フレームあたりの秒数）をかけることで、PCの性能に関わらず一定速度で減る
	value -= decrease_speed * delta
	
	# 0以下になったら0で固定し、時間切れの処理を呼ぶ
	if value <= 0:
		value = 0
		time_up()

func time_up():
	print("時間切れ！")
	# ここにゲームオーバー処理などを書く
	# SceneChanger.change_scene("res://game_over.tscn")
	
	# 0になったらこれ以上計算しないように処理を止める
	set_process(false)
