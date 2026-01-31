extends Control

# instance part========================================================================
@export var mask_texture: TextureRect
@export var mask_background: TextureRect
@export var mask_name: Label

var mask_data_local: maskdata = null

func init_mask(mask_data) -> void:
	if not mask_data:
		return
	self.mask_data_local = mask_data

	mask_texture.texture = mask_data.mask_texture
	mask_name.text = mask_data.mask_name
