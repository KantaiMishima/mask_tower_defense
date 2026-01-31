extends ColorRect

@export var maskcontainer: HBoxContainer  # set the container
@export var mask_ui_scene: PackedScene     # for 
@export var max_hand_size: int = 8         # max amount 

# array for usable masks
var current_hand: Array[Control] = []

# add mask to panel
func add_mask_to_hand(mask_data: maskdata) -> bool:
	# check the limit
	if current_hand.size() >= max_hand_size:
		print("Number of masks overed" % max_hand_size)
		return false 
	
	# generate mask ui
	var mask_ui = mask_ui_scene.instantiate() if Engine.get_version_info().major == 4 else mask_ui_scene.instance()
	mask_ui.init_mask(mask_data)
	
	# add to container
	maskcontainer.add_child(mask_ui)
	current_hand.append(mask_ui)
	print("maskui added, ui in container is ", maskcontainer.get_child_count())
	return true

# remove masks after used
func remove_mask_from_hand(mask_ui: Control) -> void:
	if current_hand.has(mask_ui):
		current_hand.erase(mask_ui)
		mask_ui.queue_free()

# clear all masks 
func clear_hand() -> void:
	for mask in current_hand:
		mask.queue_free()
	current_hand.clear()

# mask number in hand 
func get_hand_size() -> int:
	return current_hand.size()
