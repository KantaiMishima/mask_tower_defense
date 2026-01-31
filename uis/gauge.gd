extends Node2D

@export var progress: ProgressBar
@export var Trail1: Node2D
@export var Trail2: Node2D
@export var Trail3: Node2D
var boss_scene = preload("res://characters/boss.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if progress.value <= 0:
		# 各Trailの処理を停止
		Trail1.queue_free()
		Trail2.queue_free()
		Trail3.queue_free()

		var boss = boss_scene.instantiate()
		boss.global_position = $Marker2D.global_position
		get_tree().current_scene.add_child(boss)

		# このスクリプト自体も停止
		set_process(false)
	pass
