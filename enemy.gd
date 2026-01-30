extends Node2D

# 敵のシーンをインスペクターから登録
@export var enemy_scene: PackedScene

# 出現地点を配列で管理
@onready var spawn_points = [
	$SpawnPoints/Marker2D_Upper,
	$SpawnPoints/Marker2D_Middle,
	$SpawnPoints/Marker2D_Lower
]


func _on_enemy_spawn_timer_timeout() -> void:
	# 1. 敵のインスタンスを作成
	var enemy = enemy_scene.instantiate()
	
	# 2. 3つのレーンからランダムに1つ選択
	var random_marker = spawn_points.pick_random()
	
	# 3. 敵の位置を選択したレーンの位置に設定
	enemy.global_position = random_marker.global_position
	
	# 4. シーンに追加
	add_child(enemy)
	print("spawn enemy!", random_marker.global_position)
