extends Node2D
const HandPanel = preload("res://levels/hand_panel.gd")

@export var hand_panel: HandPanel  #
@export var draw_interval: float = 3.0  # 
@export var is_auto_draw: bool = true   #

var draw_timer: Timer = null

func _ready() -> void:
	randomize()
	_init_draw_timer()

func _init_draw_timer() -> void:
	draw_timer = Timer.new()
	draw_timer.wait_time = draw_interval
	draw_timer.one_shot = false  
	draw_timer.timeout.connect(_on_draw_timer_timeout)
	add_child(draw_timer)
	
	if is_auto_draw:
		draw_timer.start()

func _on_draw_timer_timeout() -> void:
	var random_mask = Masklibrary.get_random_mask()
	if not random_mask:
		print("empty")
		draw_timer.stop() 
		return
	
	var add_success = hand_panel.add_mask_to_hand(random_mask)
	
	if not add_success:
		draw_timer.stop()
		print("stop draw, over limit")

#func draw_mask_manually() -> void:
	#var random_mask = CardLibrary.get_random_card()
	#if random_card:
		#hand_panel.add_card_to_hand(random_card)

func restart_auto_draw() -> void:
	if hand_panel.get_hand_size() < hand_panel.max_hand_size and not draw_timer.is_started():
		draw_timer.start()
		print("Restart draw")
