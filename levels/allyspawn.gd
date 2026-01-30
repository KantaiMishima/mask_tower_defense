extends Node2D
const spawnpoint = preload("res://levels/spawnpoint.gd") 

@export var respawn_interval: float
var bodies_in_area: Dictionary = {}
var respawn_timer: Timer
var respawn_available: bool = false

@export var base_ally_scene: PackedScene
@export var respawn_point: spawnpoint

func _ready()-> void:
	
	respawn_timer = Timer.new()
	respawn_timer.wait_time = respawn_interval
	respawn_timer.one_shot = true  
	respawn_timer.timeout.connect(func():
		respawn_available = true
		_spawn_allies()
	)
	add_child(respawn_timer)
	respawn_timer.start()
	pass

func _on_checkingspace_body_entered(body: Node2D) -> void:
	if body != self:
		bodies_in_area[body] = true
	print(body.name, " Enter waiting area")
pass # Replace with function body.


func _on_checkingspace_body_exited(body: Node2D) -> void:
	if bodies_in_area.has(body):
		bodies_in_area.erase(body)
		respawn_available = false
		respawn_timer.start()
	print(body.name, " Leave wating area")
	pass # Replace with function body.
	

func _spawn_allies() -> void:
	if bodies_in_area.is_empty() and respawn_available:
		# for list for attack 
		var ally_scene = base_ally_scene
		var ally = ally_scene.instantiate()  
		ally.global_position = respawn_point.global_position
		get_tree().root.add_child(ally)
		
		print("generate enemy", ally.name, "at", respawn_point.spawn_name)
		
	#could only attack the first body in the area
