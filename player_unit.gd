class_name PlayerUnit
extends Unit

@onready var selection_visual: Sprite2D = $SelectionVisual

func toggle_selection_visual(visible: bool) -> void:
	selection_visual.visible = visible