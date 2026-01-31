extends ProgressBar

# 1秒間に減らしたい量（例：10なら10秒で100から0になる）
@export var decrease_speed: float = 10.0
@export var spawn_marker: Marker2D  # スポーン位置

func _process(delta):
	# delta（1フレームあたりの秒数）をかけることで、PCの性能に関わらず一定速度で減る
	value -= decrease_speed * delta
	
	# 0以下になったら0で固定し、時間切れの処理を呼ぶ
	if value <= 0:
		value = 0
		time_up()

func time_up():
	print("時間切れ！")
	set_process(false)
