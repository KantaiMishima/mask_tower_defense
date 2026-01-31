extends Node2D

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var original_parent: Node = null  
var original_position: Vector2 = Vector2.ZERO

func _ready():
	original_parent = get_parent()  # to the parent control node

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			drag_offset = get_global_mouse_position() - global_position
			original_position = global_position
			z_index = 1000
			# 元の親から削除してからrootに追加
			original_parent.remove_child(self)
			get_tree().get_root().add_child(self)
			print("dragging start")
		else:
			if is_dragging:
				is_dragging = false
				z_index = 1
				# rootから削除してから元の親に戻す
				get_tree().get_root().remove_child(self)
				original_parent.add_child(self)
				global_position = original_position
				print("dragging stop")

func _process(_delta):
	if is_dragging:
		global_position = get_global_mouse_position() - drag_offset
