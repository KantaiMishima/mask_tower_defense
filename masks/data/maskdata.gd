extends Resource
class_name maskdata  # 定义类名，方便识别

# 卡牌核心属性
@export var mask_id: String = "card_002"       # マスクID
@export var mask_name: String = "火の仮面"     # マスタの名前
@export var mask_desc: String = "隊員を石=火の鎧で強化" # 効果概要
@export var mapping_scene: PackedScene = null   # 対応している単位
#@export var cost: int = 1                      # もし必要あればのバランス制限
@export var card_texture: Texture2D = null     # マスタテクスチャ
