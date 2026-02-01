extends CharacterBody2D

@export var speed: int = 200
@export var health: int = 40
var direction: Vector2 = Vector2(-1,0)
@export var attack_damage: int = 10
@export var clear_on_death: bool = false
@onready var attacktimer: Timer = $Attacktimer
@onready var invincibilitytimer: Timer = $Invincibilitytimer
@onready var attack_area: Area2D = $Attackmotion

var Attackbility: bool = true
var Invincibility: bool = false


var current_targets: Array[Node2D] = []
var bodies_in_area: Dictionary = {}
var clear_ui = preload("res://uis/clear.tscn")
var game_over_scene = preload("res://uis/game_over.tscn")

func _ready() -> void:
	if attacktimer:
		attacktimer.one_shot = true
		attacktimer.wait_time = 1.0
		attacktimer.timeout.disconnect(_on_attacktimer_timeout)
		attacktimer.timeout.connect(_on_attacktimer_timeout)
	if invincibilitytimer:
		invincibilitytimer.one_shot = true
		invincibilitytimer.wait_time = 1.0
		invincibilitytimer.timeout.disconnect(_on_invincibilitytimer_timeout)
		invincibilitytimer.timeout.connect(_on_invincibilitytimer_timeout)
	attack_area.body_entered.connect(_on_body_enter_area)
	attack_area.body_exited.connect(_on_body_leave_area)

#set unit that entered area into check list 
func _on_body_enter_area(body: Node2D) -> void:
	if body != self and body.has_method("hit"):
		bodies_in_area[body] = true
	print(body.name, " Enter attack area")

func _on_body_leave_area(body: Node2D) -> void:
	if bodies_in_area.has(body):
		bodies_in_area.erase(body)
	print(body.name, " Leave attack area")

#attack check
func _physics_process(delta: float) -> void:
	#Movement
	var motion = direction * speed * delta
	move_and_collide(motion)
	
	# clear_on_deathがtrueの場合、画面外チェック
	if clear_on_death:
		check_off_screen()
	
	# false of empty means attackable object exist
	if not bodies_in_area.is_empty() and Attackbility:
		# for list for attack 
		for body in bodies_in_area:
			body.hit(attack_damage)
			Attackbility = false
			attacktimer.start()
			break  # attach point for area attack
	#could only attack the first body in the area

func check_off_screen() -> void:
	# 画面の左端より左に出たらゲームオーバー
	var viewport_rect = get_viewport_rect()
	if global_position.x < -100:  # 画面左端より100ピクセル外
		trigger_game_over()

func trigger_game_over() -> void:
	print("Boss escaped! Game Over")
	SceneChanger.change_scene("res://uis/game_over.tscn")
	queue_free()


func hit(damage:int) -> void:
	if Invincibility:
		return
	health -= damage
	$HitEffect.flash_item()
	print("attacked, Health remain in", health)
	if health <= 0:
		if clear_on_death:
			var ui_instance = clear_ui.instantiate()
			# ルートではなく現在のシーンに追加
			get_tree().current_scene.add_child(ui_instance)
		death()
	Invincibility = true
	invincibilitytimer.start()

func death() -> void:
	print("Death ")
	queue_free()

func _on_attacktimer_timeout() -> void:
	Attackbility = true
	print("Cooldown overed")

func _on_invincibilitytimer_timeout() -> void:
	Invincibility = false
	print("Invincible state over")
