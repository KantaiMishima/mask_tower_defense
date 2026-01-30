extends Node

# database:key=maskID，value=maskdata
var mask_database: Dictionary = {}

func _ready() -> void:
	_init_mask_database()


func _init_mask_database() -> void:
	var mask_dir = DirAccess.open("res://masks/data")
	if mask_dir:
		mask_dir.list_dir_begin()
		var file_name = mask_dir.get_next()
		while file_name != "":
			if not mask_dir.current_is_dir() and file_name.ends_with(".tres"):
				var mask_data = load("res://masks/data/" + file_name)
				mask_database[mask_data.card_id] = mask_data
			file_name = mask_dir.get_next()

func get_mask_data(mask_id: String) -> maskdata:
	return mask_database.get(mask_id, null)


func get_random_mask() -> maskdata:
	if mask_database.size == 0:
		return null
	var mask_ids = mask_database.keys()
	var random_id = mask_ids[randi() % mask_ids.size()]
	return get_mask_data(random_id)
