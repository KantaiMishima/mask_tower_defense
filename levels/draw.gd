extends Node2D
const HandPanel = preload("res://levels/hand_panel.gd")

@export var hand_panel: HandPanel  # 拖入HandPanel节点
@export var draw_interval: float = 3.0  # 每3秒发一张牌
@export var is_auto_draw: bool = true   # 是否自动发牌

# 发牌计时器
var draw_timer: Timer = null

func _ready() -> void:
	# 初始化随机数（避免每次发牌顺序一样）
	randomize()
	# 创建并配置发牌计时器
	_init_draw_timer()

# 初始化发牌计时器
func _init_draw_timer() -> void:
	draw_timer = Timer.new()
	draw_timer.wait_time = draw_interval
	draw_timer.one_shot = false  # 循环发牌
	draw_timer.timeout.connect(_on_draw_timer_timeout)
	add_child(draw_timer)
	
	# 启动计时器（如果开启自动发牌）
	if is_auto_draw:
		draw_timer.start()

# 计时器回调：发牌逻辑
func _on_draw_timer_timeout() -> void:
	# 1. 随机获取一张卡牌数据
	var random_mask = Masklibrary.get_random_mask()
	if not random_mask:
		print("empty")
		draw_timer.stop()  # 停止发牌
		return
	
	# 2. 尝试添加到手牌（自动检查上限）
	var add_success = hand_panel.add_mask_to_hand(random_mask)
	
	# 3. 若添加失败（达上限），停止发牌
	if not add_success:
		draw_timer.stop()
		print("stop draw, over limit")

# 手动触发发牌（比如按钮点击）
#func draw_mask_manually() -> void:
	#var random_mask = CardLibrary.get_random_card()
	#if random_card:
		#hand_panel.add_card_to_hand(random_card)

func restart_auto_draw() -> void:
	if hand_panel.get_hand_size() < hand_panel.max_hand_size and not draw_timer.is_started():
		draw_timer.start()
		print("Restart draw")
