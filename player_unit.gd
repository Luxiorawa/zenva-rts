class_name PlayerUnit
extends Unit

@onready var selection_visual: Sprite2D = $SelectionVisual

func _ready() -> void:
	self.gameManager.player_units.append(self)

func toggle_selection_visual(toggle: bool) -> void:
	selection_visual.visible = toggle