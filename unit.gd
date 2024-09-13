class_name Unit
extends CharacterBody2D

@export var health: int = 100
@export var damage: int = 20

@export var move_speed: float = 50.0
@export var attack_range: float = 20.0
@export var attack_speed: float = 0.5

var last_attack_time: float

var target: Unit

@onready var navigationAgent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: Sprite2D = $Sprite2D

@export var is_player: bool

func _ready() -> void:
	pass

func set_target(new_target: Unit) -> void:
	target = new_target

func move_to_location(location: Vector2) -> void:
	target = null
	navigationAgent.target_position = location

func take_damage(damage_amount: int) -> void:
	health -= damage_amount
	if health <= 0:
		queue_free()

func try_attack_target() -> void:
	var current_time := Time.get_unix_time_from_system()
	if current_time - last_attack_time > attack_speed:
		last_attack_time = current_time
		target.take_damage(damage)
		pass