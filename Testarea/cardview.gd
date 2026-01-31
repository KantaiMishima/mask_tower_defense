extends Node2D
class_name CardView

var data: maskdata
var sprite: Sprite2D

func setup(d: maskdata) -> void:
	data = d

	sprite = Sprite2D.new()
	sprite.texture = data.mask_texture
	add_child(sprite)

func _exit_tree() -> void:
	if sprite:
		sprite.queue_free()
