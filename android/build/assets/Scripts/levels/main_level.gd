extends Node2D


func _ready() -> void:
    EventBus.level_on_level_loaded.emit()