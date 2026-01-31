extends Node
class_name CardPool

@export var mask_datas: Array[maskdata]
var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func draw_random() -> maskdata:
	if mask_datas.is_empty():
		push_error("mask_datas 为空")
		return null
	return mask_datas[rng.randi_range(0, mask_datas.size() - 1)]
