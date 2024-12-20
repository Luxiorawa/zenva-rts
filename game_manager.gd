class_name GameManager
extends Node2D

var selected_unit: PlayerUnit
var player_units: Array[PlayerUnit]
var enemy_units: Array[EnemyUnit]

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			try_select_unit()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			# TODO : Gérer le maintien du clic qui ne fonctionne pas actuellement, ce qui est un peu chiant pour le déplacement.
			print("Try command unit")
			try_command_unit()

func get_selected_unit() -> Unit:
	var space := get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	var intersection := space.intersect_point(query, 1)

	if !intersection.is_empty():
		return intersection[0].collider as Unit

	return null

func try_select_unit() -> void:
	var unit := get_selected_unit()

	if unit != null and unit.is_player:
		select_unit(unit)
	else:
		unselect_unit()

func select_unit(unit: Unit) -> void:
	# User can select only one unit, so we unselect before selecting any unit.
	unselect_unit()

	selected_unit = unit
	selected_unit.toggle_selection_visual(true)

func unselect_unit() -> void:
	if selected_unit != null:
		selected_unit.toggle_selection_visual(false)
		selected_unit = null

func try_command_unit() -> void:
	if selected_unit == null:
		return
	
	var target = get_selected_unit()

	if target != null and target.is_player == false:
		selected_unit.set_target(target)
	else:
		selected_unit.move_to_location(get_global_mouse_position())
