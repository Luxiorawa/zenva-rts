class_name EnemyUnit
extends Unit

@export var detect_range: float = 100.0

func _ready() -> void:
    self.gameManager.enemy_units.append(self)

func _process(delta: float) -> void:
    if self.target == null:
        for player in self.gameManager.player_units:
            if player == null:
                continue
            
            var distanceBetweenSelfAndTarget = global_position.distance_to(player.global_position)
            print("Distance between target and enemy :", distanceBetweenSelfAndTarget)
            if distanceBetweenSelfAndTarget <= detect_range: 
                set_target(player)
    
    super(delta)
      