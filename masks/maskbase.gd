extends Node2D

# 卡牌显示样式配置
@export var mask_datas: Array[maskdata] 
@export var current_card_pos: Vector2 = Vector2(110, 560)
@export var next_card_preview_pos: Vector2 = Vector2(280, 580)
@export var card_size: Vector2 = Vector2(100, 150) 

# 4.5.1 官方随机数生成器
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()  # 初始化随机种子

# 生成随机卡牌（返回Node2D，带位置）
func generate_card_from_maskdata(mask_data: maskdata, is_preview: bool = false) -> Node2D:
	if not mask_data:
		print("❌ maskdata为空！")
		return null
	
	# 1. 创建卡牌根节点
	var card_node = Node2D.new()
	card_node.set_script(load("res://CardNode.gd"))
	card_node.data = mask_data
	
	# 2. 添加卡牌图片（读取maskdata的mask_texture）
	var card_sprite = Sprite2D.new()
	card_sprite.texture = mask_data.mask_texture
	card_sprite.scale = card_size / (card_sprite.texture.get_size() if card_sprite.texture else Vector2(1,1))
	card_node.add_child(card_sprite)
	
	# 4. 设置位置和样式（区分当前卡/预览卡）
	if is_preview:
		card_node.global_position = next_card_preview_pos
		card_node.modulate = Color(1, 1, 1, 0.6)  # 预览卡半透明
		card_node.scale = Vector2(0.7, 0.7)       # 预览卡缩小
	else:
		card_node.global_position = current_card_pos
	
	return card_node

# 随机选择maskdata并生成卡牌
func generate_random_card(is_preview: bool = false) -> Node2D:
	if mask_datas.is_empty():
		print("❌ maskdata列表为空！请拖入maskdata资源")
		return null
	
	# 随机选一个maskdata
	var random_idx = rng.randi_range(0, mask_datas.size() - 1)
	var random_mask_data = mask_datas[random_idx]
	
	# 生成卡牌显示节点
	return generate_card_from_maskdata(random_mask_data, is_preview)
