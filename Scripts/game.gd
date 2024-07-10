class_name Game
extends Node

func _init() -> void:
    ServiceLocator.GameInstance = get_node(".");

func _ready() -> void:
    EventBus.on_cycle_tick.connect(_on_cycle_tick)

    Storage.load_all();

func _on_cycle_tick() -> void:
    print("Cycle tick")