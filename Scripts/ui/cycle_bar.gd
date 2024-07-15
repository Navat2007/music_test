extends Control

@export var bar: TextureProgressBar
@export var timer: Timer


func _ready() -> void:
	#timer.timeout.connect(_on_timer_timeout)
	bar.value = 0
	bar.max_value = 100


func _process(delta):
	if Global.cycle_elapsed < Global.cycle_tick:
		Global.cycle_elapsed += delta
		var new_value: float = (Global.cycle_elapsed / Global.cycle_tick) * bar.max_value
		bar.value = new_value
	else:
		EventBus.on_cycle_tick.emit()
		Global.cycle_elapsed = 0


func _on_timer_timeout():
	#EventBus.on_cycle_tick.emit()
	#timer.start()
	pass
