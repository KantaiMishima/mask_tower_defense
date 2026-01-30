extends Control

@export var mask_texture: TextureRect
@export var mask_background: TextureRect
@export var mask_name: Label

var mask_data_local: maskdata = null

func init_card(mask_data) -> void:
	if not mask_data:
		return
	self.mask_data_local = mask_data

	mask_texture.texture = mask_data.mask_texture
	mask_name.text = mask_data.mask_name

	#mouse_filter = MouseFilter.STOP  # For contruct any action

#code below will be finish later to make the mask powerup function
#
#func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		#if card_data and card_data.summon_scene:
			#summon_ally(card_data.summon_scene)
			
			#queue_free()

#
#func summon_ally(scene: PackedScene) -> void:
	#var ally = scene.instantiate() if Engine.get_version_info().major == 4 else scene.instance()
	#get_tree().root.get_node("GameScene/AllySpawn").add_child(ally)
	#ally.global_position = get_tree().root.get_node("GameScene/AllySpawn").global_position
