extends Node2D
const spawnpoint = preload("res://levels/spawnpoint.gd") 


@export var spawn_point: spawnpoint
@export var base_spawn_interval: float = 2.0
@export var base_enemy_scene: PackedScene
@export var base_spawn_count: int = 1
var generated_enemmies_container: Node#May be moved to the level script

@export var difficulty_grow_time: float = 10.0
@export var interval_reduce_ratio: float = 0.1
@export var count_increase: int = 1
@export var hard_enemy_scene: PackedScene
@export var hard_enemy_unlock_time: float = 20.0


var current_spawn_interval: float
var current_spawn_count: int
var game_time: float = 0.0
var spawn_timer: Timer
var difficulty_timer: Timer

func _ready() -> void:
	init_enemmies_container()
	current_spawn_interval = base_spawn_interval
	current_spawn_count = base_spawn_count
	
	spawn_timer = Timer.new()
	spawn_timer.wait_time = current_spawn_interval
	spawn_timer.one_shot = false  
	spawn_timer.timeout.connect(_spawn_enemies)
	add_child(spawn_timer)
	spawn_timer.start()
	
	difficulty_timer = Timer.new()
	difficulty_timer.wait_time = difficulty_grow_time
	difficulty_timer.one_shot = false
	difficulty_timer.timeout.connect(_increase_difficulty)
	add_child(difficulty_timer)
	difficulty_timer.start()
	
	if not spawn_point or not spawn_point.is_enabled:
		print("No selected spawn point")
		spawn_timer.stop()
		
func init_enemmies_container() :
	generated_enemmies_container = Node.new()
	generated_enemmies_container.name = "GeneratedEnemmiesContainer"
	add_child(generated_enemmies_container)
	print("Created container", generated_enemmies_container.name)
	pass

func _spawn_enemies() -> void:
	if not spawn_point or not spawn_point.is_enabled:
		return
	
	for i in range(current_spawn_count):
		var enemy_scene = base_enemy_scene
		# when playing time over the threshold, unlock the stronger enemies 
		if game_time >= hard_enemy_unlock_time and hard_enemy_scene:
			# random generating different enemies
			enemy_scene = base_enemy_scene if randi() % 2 == 0 else hard_enemy_scene
		
		var enemy = enemy_scene.instantiate()  
		enemy.global_position = spawn_point.global_position
		generated_enemmies_container.add_child(enemy)
		
		print("generate enemy", enemy.name, "at", spawn_point.spawn_name)

# tutor for difficulty change
func _increase_difficulty() -> void:
	#decrease spawn interval
	current_spawn_interval = max(0.5, current_spawn_interval * (1 - interval_reduce_ratio))
	spawn_timer.wait_time = current_spawn_interval
	
	current_spawn_count += count_increase
	

	print("difiicluty changed")
	print("current playing time", game_time, "s")
	print("generate interval", current_spawn_interval, "s")
	print("generating number per wave", current_spawn_count)
	print("====================")

#Record for the total game time
func _process(delta: float) -> void:
	game_time += delta
