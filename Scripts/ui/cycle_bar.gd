extends Control

@export var timer: Timer
@export var bar: TextureProgressBar

@export var duration := 4.0

var time_elapsed := 0.0

func _ready() -> void:
    bar.value = 0
    bar.max_value = 100

func _process(delta):
    if time_elapsed < duration:
        time_elapsed += delta
        var new_value: float = (time_elapsed / duration) * bar.max_value
        bar.value = new_value
    else:
        EventBus.on_cycle_tick.emit()
        time_elapsed = 0