extends CharacterBody2D

var speed: int = 200
var health: int = 50
var direction: Vector2 = Vector2(0,0)
var attack_damage: int = 10

var Attackbility: bool = true
var Invincibility: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = direction * speed * delta
	move_and_collide(velocity)
	pass

func hit(damage:int) -> void:
	health -= damage
	if health <= 0:
		death()
	Invincibility = true
	pass

func death() -> void:
	# use for play animation
	queue_free()
	pass

func _on_attackmotion_body_entered(hurt_body: Node2D) -> void:#Attack function
	if Attackbility == true and hurt_body.has_method("hit"):
		#play attack motion 
		hurt_body.hit(attack_damage)
		Attackbility = false
	pass # Replace with function body.

#After this is the timer 
func _on_attacktimer_timeout() -> void:
	Attackbility = true
	pass # Replace with function body.
	
func _on_invincibilitytimer_timeout() -> void:
	Invincibility = false
	pass # Replace with function body.
