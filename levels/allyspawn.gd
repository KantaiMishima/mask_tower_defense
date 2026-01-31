extends Node2D
const spawnpoint = preload("res://levels/spawnpoint.gd") 

@export var respawn_interval: float
var bodies_in_area: Dictionary = {}
var respawn_timer: Timer
var respawn_available: bool = false
var generated_allies_container: Node

signal summon(spawn_pos: Vector2)

@export var base_ally_scene: PackedScene
@export var respawn_point: spawnpoint

func _ready()-> void:
	init_allies_container()
	
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

func init_allies_container():
	generated_allies_container = Node.new()
	generated_allies_container.name = "GeneratedAlliesContainer"
	add_child(generated_allies_container)
	print("Created container", generated_allies_container.name)

func _on_checkingspace_body_entered(body: Node2D) -> void:
	if body != self:
		bodies_in_area[body] = true
	print(body.name, " Enter waiting area")
pass # Replace with function body.


func _on_checkingspace_body_exited(body: Node2D) -> void:
	if bodies_in_area.has(body):
		bodies_in_area.erase(body)
		respawn_available = false
		# シーンツリー内にいる場合のみタイマーを起動
		if is_inside_tree() and respawn_timer and respawn_timer.is_inside_tree():
			respawn_timer.start()
	print(body.name, " Leave wating area")
	pass # Replace with function body.
	

func _spawn_allies() -> void:
	if bodies_in_area.is_empty() and respawn_available:
		# for list for attack 
		var ally_scene = base_ally_scene
		var ally = ally_scene.instantiate()  
		ally.global_position = respawn_point.global_position
		generated_allies_container.add_child(ally)
		print("generate enemy", ally.name, "at", respawn_point.spawn_name)
		
	#could only attack the first body in the area
func clear_area_bodies() -> void:
	# 1. 遍历字典，安全销毁所有个体（必须用for...in 拷贝的keys，避免遍历中修改字典）
	var body_keys = bodies_in_area.keys()  # 拷贝key列表，防止遍历中字典变化
	for body in body_keys:
		# 关键：先校验节点是否有效（避免销毁已释放的节点）
		if is_instance_valid(body):
			body.queue_free()  # 安全销毁（延迟到帧末执行）
			print("✅ 销毁区域内个体")
		# 从字典中移除（无论是否销毁成功）
			bodies_in_area.erase(body)
	
	# 2. 重置重生状态（可选，根据你的逻辑调整）
	respawn_available = false
	respawn_timer.start()  # 重启计时器
	print("✅ 已清空 {play_area_name if has_var('play_area_name') else '当前'} 区域内所有个体，共销毁 {body_keys.size()} 个")

func _on_checkingspace_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and bodies_in_area.is_empty() == false:
		clear_area_bodies()
		var spawn_pos = $Respawnpoints/Marker2D.global_position
		print("位置为")
		print(spawn_pos)
		summon.emit(spawn_pos)
		print("位置发送")
