extends Node

func _ready() -> void:
    EventBus.on_cycle_tick.connect(_on_cycle_tick)

func _on_cycle_tick() -> void:
    print("Cycle tick")