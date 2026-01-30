extends RefCounted

const ENEMY_WAVE_SCRIPT: Array[Dictionary] = [
	# 第一波：Spawn1生成2个基础敌人，间隔1秒，波次延迟0秒
	{
		"wave_index": 1,
		"start_delay": 2,
		"spawn_rules": [
			{
				"spawn_point": "Spawn1",
				"enemy_scene": preload("res://enemy.tscn"),
				"count": 2,
				"spawn_interval": 1.0,
				"init_params": {
					"direction": Vector2(1, 0),  # 向右移动
					"health": 40,
					"attack_damage": 10
				}
			}
		]
	}
]
