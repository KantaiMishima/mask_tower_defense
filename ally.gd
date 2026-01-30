extends CharacterBody2D

var speed: int = 200
var health: int = 40
var direction: Vector2 = Vector2(1,0)
var attack_damage: int = 10
@onready var attacktimer: Timer = $Attacktimer
@onready var invincibilitytimer: Timer = $Invincibilitytimer
@onready var attack_area: Area2D = $Attackmotion

var Attackbility: bool = true
var Invincibility: bool = false


var current_targets: Array[Node2D] = []
var bodies_in_area: Dictionary = {}

func _ready() -> void:
	if attacktimer:
		attacktimer.one_shot = true
		attacktimer.wait_time = 1.0
		attacktimer.timeout.connect(_on_attacktimer_timeout)
	if invincibilitytimer:
		invincibilitytimer.one_shot = true
		invincibilitytimer.wait_time = 1.5
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
	
	# false of empty means attackable object exist
	if not bodies_in_area.is_empty() and Attackbility:
		# for list for attack 
		for body in bodies_in_area:
			body.hit(attack_damage)
			Attackbility = false
			attacktimer.start()
			break  # attach point for area attack
	#could only attack the first body in the area


func hit(damage:int) -> void:
	if Invincibility:
		return
	health -= damage
	print("attacked, Health remain in", health)
	if health <= 0:
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
