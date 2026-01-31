extends Node2D

@export var card_pool: CardPool
@export var current_card_anchor: Node2D
@export var next_card_anchor: Node2D

@export var current_pos := Vector2(110, 560)
@export var preview_pos := Vector2(280, 580)

var current_data: maskdata
var next_data: maskdata

var current_card_view: CardView
var next_card_view: CardView

var summon_allies_container: Node2D

func _ready() -> void:
	print("MaskDisplay ready")
	print("CardPool:", card_pool)
	summon_allies_container = Node2D.new()
	summon_allies_container.name = "SummonedAllies"
	add_child(summon_allies_container)

	_draw_initial_hand()

func _draw_initial_hand() -> void:
	current_data = card_pool.draw_random()
	next_data = card_pool.draw_random()
	_refresh_views()

func _refresh_views() -> void:
	if current_card_view:
		current_card_view.queue_free()
	if next_card_view:
		next_card_view.queue_free()

	current_card_view = CardView.new()
	current_card_view.setup(current_data)
	current_card_view.global_position = current_pos
	current_card_anchor.add_child(current_card_view)

	next_card_view = CardView.new()
	next_card_view.setup(next_data)
	next_card_view.global_position = preview_pos
	next_card_view.scale = Vector2(0.7, 0.7)
	next_card_view.modulate = Color(1, 1, 1, 0.6)
	next_card_anchor.add_child(next_card_view)

func summon_current_card(spawn_pos: Vector2) -> void:
	if not current_data:
		return
	if not current_data.mapping_scene:
		return

	var ally := current_data.mapping_scene.instantiate()
	ally.global_position = spawn_pos
	summon_allies_container.add_child(ally)

	_consume_and_rotate()

func _consume_and_rotate() -> void:
	current_data = next_data
	next_data = card_pool.draw_random()
	_refresh_views()


func _on_allyspawn_summon(spawn_pos: Vector2) -> void:
	summon_current_card(spawn_pos)
	pass # Replace with function body.


func _on_allyspawn_2_summon(spawn_pos: Vector2) -> void:
	summon_current_card(spawn_pos)
	pass # Replace with function body.


func _on_allyspawn_3_summon(spawn_pos: Vector2) -> void:
	summon_current_card(spawn_pos)
	pass # Replace with function body.
