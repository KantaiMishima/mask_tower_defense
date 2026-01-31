extends Resource
class_name maskdata  

@export var mask_id: String = ""       # マスクID
@export var mask_name: String = ""     # マスタの名前
@export var mask_desc: String = "" # 効果概要
@export var mapping_scene: PackedScene = null   # 対応している単位
#@export var cost: int = 1                      # もし必要あればのバランス制限
@export var mask_texture: Texture2D = null     # マスタテクスチャ
