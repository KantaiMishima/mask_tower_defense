extends CharacterBody2D

@export var speed = 200.0

func _physics_process(_delta):
	# 左方向（マイナスX方向）へ移動
	velocity.x = -speed
	move_and_slide()

# 画面外に出たら削除（メモリ節約）
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	print("destroy enemy!")
