extends CharacterBody2D

var speed: int = 200
var health: int = 50
var RIGHT: Vector2 = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = RIGHT * speed * delta
	move_and_collide(velocity)
	pass
