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

func _physics_process(_delta: float) -> void:
	if navigationAgent.is_navigation_finished():
		return
	
	var direction = global_position.direction_to(navigationAgent.get_next_path_position())
	velocity = direction * move_speed

	move_and_slide()

func _process(_delta: float) -> void:
	target_check()

func target_check() -> void:
	if target != null:
		var distance = global_position.distance_to(target.global_position)
		if distance <= attack_range:
			navigationAgent.target_position = global_position
			try_attack_target()
		else:
			navigationAgent.target_position = target.global_position

func move_to_location(location: Vector2) -> void:
	target = null
	navigationAgent.target_position = location

func set_target(new_target: Unit) -> void:
	target = new_target

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